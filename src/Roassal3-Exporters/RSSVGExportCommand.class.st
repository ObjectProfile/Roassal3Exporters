"
Export the current canvas to svg image file using the inspector
"
Class {
	#name : #RSSVGExportCommand,
	#superclass : #RSExportCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #default }
RSSVGExportCommand class >> defaultDescription [
	^ 'Export to SVG image file'
]

{ #category : #default }
RSSVGExportCommand class >> defaultName [
	^ 'SVG'
]

{ #category : #accessing }
RSSVGExportCommand >> exporterClass [
	^ RSSVGCairoExporter
]
