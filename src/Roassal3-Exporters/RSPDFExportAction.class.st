"
TODO
"
Class {
	#name : #RSPDFExportAction,
	#superclass : #RSAbstractExportAction,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSPDFExportAction >> defaultExporter [
	^ RSPDFExporter new
]
