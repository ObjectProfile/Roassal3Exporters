"
I represent the exporter of Roassal3 shapes using AthensCairoSVGSurface
"
Class {
	#name : #RSSVGCairoExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #accessing }
RSSVGCairoExporter class >> extension [
	^ 'svg'
]

{ #category : #public }
RSSVGCairoExporter >> cairoSurfaceClass [ 
	^ AthensCairoSVGSurface
]
