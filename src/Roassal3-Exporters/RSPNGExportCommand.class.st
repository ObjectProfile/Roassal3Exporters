"
Used to create a PNG image from a roassal canvas from the inspector
"
Class {
	#name : #RSPNGExportCommand,
	#superclass : #RSExportCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #default }
RSPNGExportCommand class >> defaultDescription [
	^ 'Export to a png image file'
]

{ #category : #default }
RSPNGExportCommand class >> defaultName [
	^ 'PNG'
]

{ #category : #accessing }
RSPNGExportCommand >> exporterClass [
	^ RSPNGExporter
]
