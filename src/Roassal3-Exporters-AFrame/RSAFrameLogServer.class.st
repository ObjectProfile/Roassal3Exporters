"
I am a simple log server for aFrameExporter
"
Class {
	#name : #RSAFrameLogServer,
	#superclass : #Object,
	#instVars : [
		'rawServer',
		'port',
		'exporter',
		'directory'
	],
	#category : #'Roassal3-Exporters-AFrame-Server'
}

{ #category : #'user requests' }
RSAFrameLogServer >> createFile: entity [
	| file |
	file := self logsDirectory asFileReference.
	file exists ifFalse: [ file createDirectory ].
	file := file / UUID new asString36.
	file writeStreamDo: [ :stream | self write: entity to: stream ].
]

{ #category : #accessing }
RSAFrameLogServer >> exporter [
	^ exporter
]

{ #category : #accessing }
RSAFrameLogServer >> exporter: aRSAFrameExporter [ 
	exporter := aRSAFrameExporter
]

{ #category : #'user requests' }
RSAFrameLogServer >> handleLogRequest: request [
	self createFile: request entity.
	
	^ ZnResponse ok: (ZnEntity json: '"foo"' ).
]

{ #category : #'user requests' }
RSAFrameLogServer >> handleMainRequest: request [
	| html |
	html := String streamContents: [ :temporalStream | self exporter writeToStream: temporalStream ].
	^ ZnResponse ok: (ZnEntity html: html)
]

{ #category : #initialization }
RSAFrameLogServer >> initialize [
	super initialize.
	self port: 8080.
]

{ #category : #accessing }
RSAFrameLogServer >> localUrl [
	^ rawServer localUrl
]

{ #category : #accessing }
RSAFrameLogServer >> logsDirectory [
	^ directory
]

{ #category : #accessing }
RSAFrameLogServer >> logsDirectory: aString [ 
	directory := aString
]

{ #category : #accessing }
RSAFrameLogServer >> port [

	^ port
]

{ #category : #accessing }
RSAFrameLogServer >> port: aNumber [
	port := aNumber
]

{ #category : #public }
RSAFrameLogServer >> start [
	rawServer := ZnServer on: self port.
	rawServer start.
	rawServer delegate
		map: #aFrame to: [ :request | self handleMainRequest: request ];
		map: #aFrameLog to: [ :request | self handleLogRequest: request ].
]

{ #category : #public }
RSAFrameLogServer >> stop [
	rawServer stop
]

{ #category : #'user requests' }
RSAFrameLogServer >> write: entity to: stream [
	entity ifNil: [ ^ self ].
	stream nextPutAll: (entity at: #navigator ifAbsent: ['NO DAta']).
]
