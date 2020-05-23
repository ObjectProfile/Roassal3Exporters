"
TODO
"
Class {
	#name : #RSPNGExporter,
	#superclass : #RSRoassalExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSPNGExporter >> exportToFile: file [
	| morph |
	morph := self morph.
	self cameraSetter set: [ 
		morph surface writeToPng: file pathString.
		 ]
]

{ #category : #accessing }
RSPNGExporter >> extension [
	^ 'png'
]
