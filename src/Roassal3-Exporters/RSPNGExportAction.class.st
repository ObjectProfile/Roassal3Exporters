"
TODO
"
Class {
	#name : #RSPNGExportAction,
	#superclass : #RSAbstractExportAction,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSPNGExportAction >> defaultExporter [
	^ RSPNGExporter new
]
