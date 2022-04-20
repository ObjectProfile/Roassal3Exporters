Extension { #name : #StObjectInspectorPresenter }

{ #category : #'*Roassal3-Exporters' }
StObjectInspectorPresenter class >> roassal3CommandsWith: aPresenter forRootGroup: aRootCommandsGroup [
	<extensionCommands>
	| group |
	aPresenter model inspectedObject class = RSCanvas
		ifFalse: [ ^ self ].
	group := CmCommandGroup forSpec
		beToolbarPopoverButton;
		name: 'ZExporter';
		icon: (aPresenter application iconNamed: #smallExport);
		yourself.
	RSExportCommand subclassesDo: [ :cls | group register: cls forSpec ].
	aRootCommandsGroup register: group
]
