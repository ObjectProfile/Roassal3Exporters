Class {
	#name : #RSAFrameServerTest,
	#superclass : #TestCase,
	#instVars : [
		'aFrameExporter',
		'server'
	],
	#category : #'Roassal3-Exporters-AFrame-Tests'
}

{ #category : #running }
RSAFrameServerTest >> setUp [
	| canvas |
	super setUp.
	canvas := RSCanvas new.
	Collection withAllSubclasses do: [ :cls |
		canvas add: (RSEllipse new
			model: cls;
			draggable;
			size: 5;
			yourself)
		 ].

	RSNormalizer color
		from: (Color gray alpha: 0.5);
		to: (Color red alpha: 0.5);
		shapes: canvas nodes;
		normalize: #numberOfMethods.
	RSNormalizer size
		shapes: canvas nodes;
		normalize: #numberOfMethods.
	RSEdgeBuilder line
		canvas: canvas;
		connectFrom: #superclass.
	RSTreeLayout on: canvas nodes.
	
	server := RSAFrameLogServer new.
	server exporter: canvas aFrameExporter.
	server logsDirectory: './tests'.
	server start.
	
]

{ #category : #running }
RSAFrameServerTest >> tearDown [
	server stop
]

{ #category : #tests }
RSAFrameServerTest >> testAddLogs [
	| client directory |
	client := ZnClient new.
	client url: server localUrl; addPath: #aFrameLog.
	client get.
	self assert: client isSuccess.
	client close.
	directory := server logsDirectory asFileReference.
	self assert: directory children isNotEmpty.
	directory ensureDeleteAll. 
]

{ #category : #tests }
RSAFrameServerTest >> testMainPage [
	| client |
	client := ZnClient new.
	client url: server localUrl; addPath: #aFrame.
	client get.
	self assert: client isSuccess.
	client close.
]
