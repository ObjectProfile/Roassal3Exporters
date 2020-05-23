"
TODO
"
Class {
	#name : #RSCamSetter,
	#superclass : #Object,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Exporters-Setters'
}

{ #category : #accessing }
RSCamSetter >> canvas [
	^ canvas
]

{ #category : #accessing }
RSCamSetter >> canvas: aRSCanvas [
	canvas := aRSCanvas
]

{ #category : #hooks }
RSCamSetter >> extent [
	^ canvas extent
]

{ #category : #public }
RSCamSetter >> set: aBlock [
	| camera |
	self setCanvasCamera.
	camera := canvas camera copy.
	canvas morph drawOnMockCanvas.
	self setCamera.
	aBlock value.
	canvas camera: camera.
]

{ #category : #hooks }
RSCamSetter >> setCamera [
]

{ #category : #hooks }
RSCamSetter >> setCanvasCamera [
	| extent morph |
	extent := self extent.
	morph := canvas morph ifNil: [ canvas createMorph ].
	morph extent = extent ifFalse: [ morph extent: extent ].
]
