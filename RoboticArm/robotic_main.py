#!/usr/bin/python3

########################################################################
# Basic Libraries
########################################################################
import sys
from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QTimer, QObject, Signal, Slot
from PySide6.QtTest import *

########################################################################
# Special Libraries
########################################################################
#import sqlite3
#import struct
#from pylogix import PLC
#import pymodbus
#import snap7

########################################################################
# Graphic interface
########################################################################


########################################################################
# Main Class
########################################################################
class Aplicacion(QObject):
	
	###### signals to exchange Python -QML #############################
	
	updated = Signal(str, arguments=['time'])	
	dataposition0 = Signal(str, str, str, str, str, str, str, str)
	dataposition1 = Signal(str, str, str, str, str, str, str, str)
	dataposition2 = Signal(str, str, str, str, str, str, str, str)
	dataposition3 = Signal(str, str, str, str, str, str, str, str)
	dataposition4 = Signal(str, str, str, str, str, str, str, str)
	
	def __init__(self):
		super().__init__()
		self.app = QGuiApplication(sys.argv)
		self.app.setWindowIcon(QIcon("icon.png"))
		self.engine = QQmlApplicationEngine(self)
		self.engine.quit.connect(self.app.quit)
		self.engine.rootContext().setContextProperty("backend", self)
		self.engine.load('content/App.qml')
		
		###### Init Timers: CLOCK | SAMPLER ############################
		self.setupWidgets()
		self.iniTemporizador()
		sys.exit(self.app.exec())
		
	####################################################################
	##### Setup Widgets - OPC - status switchs - sliders - graphics -###
	####################################################################
	def setupWidgets(self):
		# Matrix [J1, J2, J3, J4, J5, J6, ClawAngle ]
		self.lastd0 = [None]*8
		self.lastd1 = [None]*8
		self.lastd2 = [None]*8
		self.lastd3 = [None]*8
		self.lastd4 = [None]*8
		self.poses = 0
		self.sliderRot1 = 110
		self.sliderRot2 = 45
		self.sliderRot3 = 45
		self.sliderRot4 = 0
		self.sliderRot5 = 60
		self.sliderRot6 = 90
		self.pinza = 50
		self.localRemote = 0
		self.i = -1
		
		# EXAMPLE OF MOVEMENTS
		# Matrix [J1, J2, J3, J4, J5, J6, ClawAngle ]
		self.matrix = [[ 0, 90, 0, 0, 0, 0, 0],
						[ 0, 90, 45, 0, 0, 0, 0],
						[ 0, 90, 45, 0, 45, 0, 0],
						[ 60, 90, 45, 0, 45, 0, 0],
						[ 60, 90, 45, 45, 45, 0, 0],
						[ 60, 90, 45, 45, 45, 0, 90], 
						[ 60, 90, 45, 45, 45, 180, 90],
						[130, 90, 45, 45, 45, -300, 45],
						[0, 0, 0, 0, 0, 0, 0]]
	####################################################################
	# TIMER SAMPLER 
	####################################################################
	def iniTemporizador(self):
		self.temporizador = QTimer()
		self.temporizador.setInterval(2000)  # msecs 100 = 1/10th sec
		self.temporizador.timeout.connect(lambda:self.metMuestreo())
		self.temporizador.start()

	def metMuestreo(self):
		self.i = self.i + 1
		if self.localRemote == 1:
			self.sliderRot1 = self.matrix[self.i][0]
			self.sliderRot2 = self.matrix[self.i][1]
			self.sliderRot3 = self.matrix[self.i][2]
			self.sliderRot4 = self.matrix[self.i][3]
			self.sliderRot5 = self.matrix[self.i][4]
			self.sliderRot6 = self.matrix[self.i][5]
			self.pinza = self.matrix[self.i][6]
			#print(self.i, self.matrix[self.i])
			self.valuesScreen(self.i)
			if self.i >= 8:
				self.i = -1
		
		if self.i >= 8:
				self.i = -1
	
	####################################################################
	# Show data on screen
	####################################################################
	def valuesScreen(self,pose):
		ps=str(pose)
		r1=round(self.sliderRot1,2)
		r2=round(self.sliderRot2,2)
		r3=round(self.sliderRot3,2)
		r4=round(self.sliderRot4,2)
		r5=round(self.sliderRot5,2)
		r6=round(self.sliderRot6,2)
		cl=round(self.pinza,2,)
		
		newdato= [ps, r1, r2, r3, r4, r5, r6, cl]

		for i in range (8):
			self.lastd4[i] = self.lastd3[i]
			self.lastd3[i] = self.lastd2[i]
			self.lastd2[i] = self.lastd1[i]
			self.lastd1[i] = self.lastd0[i]
			self.lastd0[i] = str(newdato[i])
		
		self.dataposition0.emit(self.lastd0[0], self.lastd0[1], self.lastd0[2],self.lastd0[3], self.lastd0[4], self.lastd0[5], self.lastd0[6], self.lastd0[7])
		self.dataposition1.emit(self.lastd1[0], self.lastd1[1], self.lastd1[2],self.lastd1[3], self.lastd1[4], self.lastd1[5], self.lastd1[6], self.lastd1[7])
		self.dataposition2.emit(self.lastd2[0], self.lastd2[1], self.lastd2[2],self.lastd2[3], self.lastd2[4], self.lastd2[5], self.lastd2[6], self.lastd2[7])
		self.dataposition3.emit(self.lastd3[0], self.lastd3[1], self.lastd3[2],self.lastd3[3], self.lastd3[4], self.lastd3[5], self.lastd3[6], self.lastd3[7])
		self.dataposition4.emit(self.lastd4[0], self.lastd4[1], self.lastd4[2],self.lastd4[3], self.lastd4[4], self.lastd4[5], self.lastd4[6], self.lastd4[7])
		#print (pose)
	####################################################################
	# slider Rotacion data QML ==>>  PYTHON
	####################################################################
	@Slot('QString','float')
	def setSlider1(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot1 != dato) & (self.localRemote == 0):
			 self.sliderRot1 = dato
			 self.valuesScreen("SJ1")
	
	@Slot('QString','float')
	def setSlider2(self, pin, value): 
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot2 != dato) & (self.localRemote == 0):
			 self.sliderRot2 = dato
			 self.valuesScreen("SJ2")
	
	@Slot('QString','float')
	def setSlider3(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot3 != dato) & (self.localRemote == 0):
			 self.sliderRot3 = dato
			 self.valuesScreen("SJ3")
	
	@Slot('QString','float')
	def setSlider4(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot4 != dato) & (self.localRemote == 0):
			 self.sliderRot4 = dato
			 self.valuesScreen("SJ4")
		
	@Slot('QString','float')
	def setSlider5(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot5 != dato) & (self.localRemote == 0):
			 self.sliderRot5 = dato
			 self.valuesScreen("SJ5")
		
	@Slot('QString','float')
	def setSlider6(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.sliderRot6 != dato) & (self.localRemote == 0):
			 self.sliderRot6 = dato
			 self.valuesScreen("SJ6")
	
	@Slot('QString','float')
	def setSlider7(self, pin, value):
		#print (pin, value)
		dato = float(value)
		if (self.pinza != dato) & (self.localRemote == 0):
			 self.pinza = dato
			 self.valuesScreen("CLA")

	####################################################################
	# button poses robot ==>>  PYTHON
	####################################################################
	@Slot('QString','int')
	def setPose1(self, pose, value):
		if self.localRemote == 0: 
			self.poses = int(value)
			#print(pose)
			self.sliderRot1 = 110
			self.sliderRot2 = 40
			self.sliderRot3 = 20
			self.sliderRot4 = 50
			self.sliderRot5 = 45
			self.sliderRot6 = 45
			self.pinza = 90
			self.valuesScreen(pose)
	
	@Slot('QString','int')
	def setPose2(self, pose, value): 
		if self.localRemote == 0:
			self.poses = int(value)
			#print(pose)
			self.sliderRot1 = 40
			self.sliderRot2 = 20
			self.sliderRot3 = 80
			self.sliderRot4 = 10
			self.sliderRot5 = -60
			self.sliderRot6 = 80
			self.pinza = 45
			self.valuesScreen(pose)
		
	@Slot('QString','int')
	def setPose3(self, pose, value): 
		if self.localRemote == 0:
			self.poses = int(value)
			#print(pose)
			self.sliderRot1 = -50
			self.sliderRot2 = -40
			self.sliderRot3 = -20
			self.sliderRot4 = -50
			self.sliderRot5 = -45
			self.sliderRot6 = -45
			self.pinza = 0
			self.valuesScreen(pose)
	
	@Slot('QString','int')
	def setReset(self, pose, value): 
		if self.localRemote == 0:
			self.poses = int(value)
			#print(pose)
			self.sliderRot1 = 0
			self.sliderRot2 = 0
			self.sliderRot3 = 0
			self.sliderRot4 = 0
			self.sliderRot5 = 0
			self.sliderRot6 = 0
			self.pinza = 0
			self.valuesScreen(pose)
		
	####################################################################
	#  Switch Local Remote data QML ==>>  PYTHON
	####################################################################
	@Slot('QString','QString')
	def setlocalRemote(self, pin, value):
		self.localRemote = int(value)
		#print (pin, self.localRemote)
	
	####################################################################
	# SEND DATA  FROM PYTHON  ==>> QML: DATA ANGLES ON JOINTS
	####################################################################
	@Slot(result=float)
	def get_angulo1(self):
		return self.sliderRot1
	
	@Slot(result=float)
	def get_angulo2(self):
		return self.sliderRot2
		
	@Slot(result=float)
	def get_angulo3(self):
		return self.sliderRot3
		
	@Slot(result=float)
	def get_angulo4(self):
		return self.sliderRot4
		
	@Slot(result=float)
	def get_angulo5(self):
		return self.sliderRot5 
		
	@Slot(result=float)
	def get_angulo6(self):
		return self.sliderRot6
		
	@Slot(result=float)
	def get_angulopinza(self):
		return self.pinza  

####################################################################
###### MAIN ROUTINE
####################################################################
if __name__ == '__main__':
	main = Aplicacion()

