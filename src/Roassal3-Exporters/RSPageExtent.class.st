"
Check https://www.prepressure.com/library/paper-size#ANSI
"
Class {
	#name : #RSPageExtent,
	#superclass : #Object,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSPageExtent class >> a4 [
	^ self from: 595 point @ 842 point
]

{ #category : #public }
RSPageExtent class >> from: pointInUnits [
	^ (pointInUnits x as: #point) value @ (pointInUnits y as: #point) value
]

{ #category : #public }
RSPageExtent class >> letter [
	^ self from: 612 point @ 792 point
]
