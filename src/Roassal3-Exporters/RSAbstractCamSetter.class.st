"
TODO
"
Class {
	#name : #RSAbstractCamSetter,
	#superclass : #Object,
	#instVars : [
		'canvas'
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

{ #category : #public }
RSAbstractCamSetter >> set: aBlock [
	| camera |
	self setCanvasCamera.
	camera := canvas camera copy.
	canvas morph drawOnMockCanvas.
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
