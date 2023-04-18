"
TODO
"
Class {
	#name : #RSAbstractCamSetter,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'shouldUseDoubleDraw'
	],
	#category : #'Roassal3-Exporters-Setters'
}

{ #category : #accessing }
RSAbstractCamSetter >> canvas [
	^ canvas
]

{ #category : #accessing }
RSAbstractCamSetter >> canvas: aRSCanvas [
	canvas := aRSCanvas
]

{ #category : #hooks }
RSAbstractCamSetter >> extent [
	^ canvas extent
]

{ #category : #initialization }
RSAbstractCamSetter >> initialize [
	super initialize.
	self useDoubleDraw
]

{ #category : #testing }
RSAbstractCamSetter >> noDoubleDraw [
	shouldUseDoubleDraw := false
]

{ #category : #public }
RSAbstractCamSetter >> set: aBlock [
	| camera |
	self setCanvasCamera.
	camera := canvas camera copy.
	camera matrix: canvas camera matrix copy.
	self shouldUseDoubleDraw 
		ifTrue: [ canvas morph drawOnMockCanvas ].
	self setCamera.
	aBlock value.
	canvas camera: camera.
]

{ #category : #hooks }
RSAbstractCamSetter >> setCamera [
]

{ #category : #hooks }
RSAbstractCamSetter >> setCanvasCamera [
	| extent morph |
	extent := self extent.
	morph := canvas morph ifNil: [ canvas createMorph ].
	morph extent = extent ifFalse: [ morph extent: extent ].
]

{ #category : #testing }
RSAbstractCamSetter >> shouldUseDoubleDraw [
	^ shouldUseDoubleDraw
]

{ #category : #testing }
RSAbstractCamSetter >> useDoubleDraw [
	shouldUseDoubleDraw := true.
]
