"
TODO
"
Class {
	#name : #RSZoomToShapesSetter,
	#superclass : #RSAbstractCamSetter,
	#category : #'Roassal3-Exporters-Setters'
}

{ #category : #hooks }
RSZoomToShapesSetter >> extent [
	^ canvas encompassingRectangle extent
]

{ #category : #hooks }
RSZoomToShapesSetter >> setCamera [
	| rect |
	rect := canvas encompassingRectangle. 
	canvas camera
		position: rect floatCenter;
		scale: 1
]
