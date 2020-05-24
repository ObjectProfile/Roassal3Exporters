"
TODO
"
Class {
	#name : #RSSVGExportAction,
	#superclass : #RSAbstractExportAction,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSSVGExportAction >> defaultExporter [
	^ RSSVGExporter new
]
