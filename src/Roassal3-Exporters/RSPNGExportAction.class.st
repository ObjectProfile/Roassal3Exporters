"
TODO
"
Class {
	#name : #RSPNGExportAction,
	#superclass : #Object,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSPNGExportAction >> defaultExporter [
	^ RSPNGExporter new
]
