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

{ #category : #tests }
RSAFrameExporterTest >> testBox [
	| result box |
	result := '<a-box position="0.0 0.5 0" width=" 0.0 " height=" 0.0" depth=" 0.0" color= "#9F9F9F" change-color-on-hover="color: #E9E9E9" roughness=" 1.0" metalness=" 0.2" event-set__enter="_event: mouseenter;  _target:#idPopUP; visible: true;" event-set__leave="_event: mouseleave;  _target: #idPopUP; visible: false;" ></a-box>'.
	box := RSBox new.
	box printOnAFrame: aFrameExporter.
	self assert: aFrameExporter stream contents equals: result.
]
