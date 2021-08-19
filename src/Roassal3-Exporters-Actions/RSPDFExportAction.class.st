"
TODO
"
Class {
	#name : #RSPDFExportAction,
	#superclass : #Object,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSPDFExportAction >> defaultExporter [
	^ RSPDFExporter new
]
