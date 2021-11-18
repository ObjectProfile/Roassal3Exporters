"
TODO
"
Class {
	#name : #RSSVGCairoExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSSVGCairoExporter >> cairoSurfaceClass [ 
	^ AthensCairoSVGSurface
]

{ #category : #accessing }
RSSVGCairoExporter >> extension [
	^ 'svg'
]
