"
Used to export roassal canvas to pdf file
"
Class {
	#name : #RSPDFExportCommand,
	#superclass : #RSExportCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #accessing }
RSPDFExportCommand >> exporterClass [
	^ RSPDFCairoExporter
]
