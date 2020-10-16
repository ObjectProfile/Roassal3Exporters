Class {
	#name : #RSAFrameExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'imgFloor',
		'aFrameExporter'
	],
	#category : #'Roassal3-Exporters-Tests'
}

{ #category : #running }
RSAFrameExporterTest >> setUp [
	super setUp.
	imgFloor 	:= 'https://i.imgur.com/dckg70j.jpg'.
	aFrameExporter := RSAFrameExporter new.
	aFrameExporter stream: (WriteStream on: String new).
]
