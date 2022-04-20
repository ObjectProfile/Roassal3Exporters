"
Export the current canvas to svg image file using the inspector
"
Class {
	#name : #RSSVGExportCommand,
	#superclass : #RSExportCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #accessing }
RSSVGExportCommand >> exporterClass [
	^ RSSVGCairoExporter
]
