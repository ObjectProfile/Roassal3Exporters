"
Used to export roassal canvas to pdf file
"
Class {
	#name : #RSPDFExportCommand,
	#superclass : #RSExportCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #default }
RSPDFExportCommand class >> defaultDescription [
	^ 'Export to pdf file'
]

{ #category : #default }
RSPDFExportCommand class >> defaultName [
	^ 'PDF'
]

{ #category : #accessing }
RSPDFExportCommand >> exporterClass [
	^ RSPDFCairoExporter
]
