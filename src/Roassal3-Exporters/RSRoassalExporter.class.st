"
I represent the abstract class to export Roassal3 shapes in different formats.
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
RSRoassalExporter class >> extension [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSRoassalExporter >> baseName [
	| file ext |
	file := self fileName.
	ext := self extension.
	file := (file endsWith: ext)
		ifTrue: [ file ]
		ifFalse: [ file, '.', ext ].
	^ file
]

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
	^ self baseName asFileReference
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
		ifFalse: [ RSGroup new ].
	canvas fixedShapes: new.
	[ self exportToFile: file ] ensure: [ canvas fixedShapes: old ].
	^ file pathString
]

{ #category : #public }
RSRoassalExporter >> exportToFile: file [
	self subclassResponsibility
]

{ #category : #accessing }
RSRoassalExporter >> extension [
	^ self class extension
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
	self withoutFixedShapes.
	self zoomToCurrentCamera.
]

{ #category : #accessing }
RSRoassalExporter >> morph [
	^ canvas morph ifNil: [ canvas createMorph ]
]

{ #category : #configuration }
RSRoassalExporter >> noDoubleDraw [
	self cameraSetter noDoubleDraw
]

{ #category : #configuration }
RSRoassalExporter >> noFixedShapes [

	self deprecated: 'Use withoutFixedShapes instead'
		transformWith: '`@receiver noFixedShapes' -> ' `@receiver withoutFixedShapes'.
	self withoutFixedShapes
]

{ #category : #removing }
RSRoassalExporter >> removeIfNecessary: aFileName [
	aFileName exists ifTrue: [ aFileName delete ]
]

{ #category : #configuration }
RSRoassalExporter >> useDoubleDraw [
	self cameraSetter useDoubleDraw
]

{ #category : #configuration }
RSRoassalExporter >> withFixedShapes [
	showFixedShapes := true
]

{ #category : #configuration }
RSRoassalExporter >> withoutFixedShapes [
	showFixedShapes := false
]

{ #category : #configuration }
RSRoassalExporter >> zoomToCurrentCamera [
	self cameraSetter: RSCamSetter new
]

{ #category : #configuration }
RSRoassalExporter >> zoomToShapes [
	self cameraSetter: RSZoomToShapesSetter new
]
