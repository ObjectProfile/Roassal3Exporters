Class {
	#name : #RSAFrameExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'imgFloorBase64'
	],
	#category : #'Roassal3-Exporters-Tests'
}

{ #category : #running }
RSAFrameExporterTest >> setUp [
		super setUp.
		imgFloorBase64 	:= 'https://i.imgur.com/dckg70j.jpg'.
	
]
