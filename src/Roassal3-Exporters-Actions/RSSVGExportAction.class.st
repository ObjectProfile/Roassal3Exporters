"
TODO
"
Class {
	#name : #RSSVGExportAction,
	#superclass : #Object,
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #hooks }
RSSVGExportAction >> defaultExporter [
	^ RSSVGExporter new
]
