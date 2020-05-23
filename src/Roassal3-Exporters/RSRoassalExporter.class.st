"
TODO
"
Class {
	#name : #RSRoassalExporter,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'fileName',
		'showFixedShapes',
		'cameraSetter'
	],
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #accessing }
RSRoassalExporter >> cameraSetter [ 
	^ cameraSetter
]

{ #category : #accessing }
RSRoassalExporter >> cameraSetter: aRSCameraSetter [
	cameraSetter := aRSCameraSetter.
	cameraSetter canvas: canvas.
]

{ #category : #accessing }
RSRoassalExporter >> canvas: aRSCanvas [ 
	canvas := aRSCanvas.
	cameraSetter canvas: canvas
]

{ #category : #accessing }
RSRoassalExporter >> createFile [
	| file ext |
	file := self fileName.
	ext := self extension.
	file := (file endsWith: ext)
		ifTrue: [ file ]
		ifFalse: [ file, '.', ext ].
	^ file asFileReference
]

{ #category : #accessing }
RSRoassalExporter >> defaultFileName [
	^ Time microsecondClockValue asString
]

{ #category : #public }
RSRoassalExporter >> export [
	| file old new |
	canvas ifNil: [ self error: 'canvas can not be nil' ].
	file := self createFile.
	old := canvas fixedShapes.
	new := showFixedShapes 
		ifTrue: [ canvas fixedShapes ]
		ifFalse: [ #() ].
	canvas fixedShapes: new.
	[self exportToFile: file] 
		ensure: [ canvas fixedShapes: old ].
	^ file pathString

]

{ #category : #public }
RSRoassalExporter >> exportToFile: file [
	self subclassResponsibility
]

{ #category : #accessing }
RSRoassalExporter >> extension [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSRoassalExporter >> fileName [
	^ fileName ifNil: [ fileName := self defaultFileName ]
]

{ #category : #accessing }
RSRoassalExporter >> fileName: aString [
	fileName := aString
]

{ #category : #initialization }
RSRoassalExporter >> initialize [
	super initialize.
	self withFixedShapes.
	self zoomToCurrentCamera.
]

{ #category : #accessing }
RSRoassalExporter >> morph [
	^ canvas morph ifNil: [ canvas createMorph ]
]

{ #category : #configuration }
RSRoassalExporter >> noFixedShapes [
	showFixedShapes := false
]

{ #category : #configuration }
RSRoassalExporter >> withFixedShapes [
	showFixedShapes := true
]

{ #category : #configuration }
RSRoassalExporter >> zoomToCurrentCamera [
	self cameraSetter: RSCamSetter new
]

{ #category : #configuration }
RSRoassalExporter >> zoomToShapes [
	self cameraSetter: RSZoomToShapesSetter new
]
