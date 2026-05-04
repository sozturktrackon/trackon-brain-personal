---
title: B2 verification — Schema-driven screen designer
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - adaptive-ctrm-gap-analysis.md
  - adaptive-ctrm-gap-analysis-v2.md
---

# B2 verification — Schema-driven screen designer

**Original claim (v1 Section 3):** "no designer UI; field rendering is a hard-coded JSX cascade. Blocks point 3 entirely."

Evidence pass, same rigour demanded as the B1 correction.

---

## 1. Files under `react-ui/src/components/Entity/` and `react-ui/src/views/pages/Administration/`

### `react-ui/src/components/Entity/` (29 files)

| File | Size | What it does |
|---|---|---|
| [AddReferentialConstraintDialog.tsx](../../../react-ui/src/components/Entity/AddReferentialConstraintDialog.tsx) | 4.6 KB | Dialog to add an FK constraint between entities |
| [ColumnMappingModal.tsx](../../../react-ui/src/components/Entity/ColumnMappingModal.tsx) | 10 KB | CSV-import column ↔ entity-field mapping UI |
| [DetailEntityResults.tsx](../../../react-ui/src/components/Entity/DetailEntityResults.tsx) | 2.6 KB | Renders nested detail-entity rows under a parent |
| **[EntityBuilder.tsx](../../../react-ui/src/components/Entity/EntityBuilder.tsx)** | **88 KB** | **Entity-metadata schema editor** — add attributes, types, options, RBAC flags, nested attributes, IDGeneration. **Not a visual layout designer; it auto-generates a default formLayout on save.** |
| [ExportGridDialog.tsx](../../../react-ui/src/components/Entity/ExportGridDialog.tsx) | 4.7 KB | CSV/Excel export dialog for a grid |
| [FilterFormTemplate.tsx](../../../react-ui/src/components/Entity/FilterFormTemplate.tsx) | 14 KB | Filter-builder form for grid filtering |
| [FilterTemplate.tsx](../../../react-ui/src/components/Entity/FilterTemplate.tsx) | 2.7 KB | Grid column filter template |
| [GridFilter/](../../../react-ui/src/components/Entity/GridFilter/) | — | Folder of grid-filter sub-components |
| [GridLoadingComponent.tsx](../../../react-ui/src/components/Entity/GridLoadingComponent.tsx) | 1.8 KB | Loading spinner for grid |
| [GridSettings.tsx](../../../react-ui/src/components/Entity/GridSettings.tsx) | 50 KB | Grid column/settings panel |
| [MissingFields.tsx](../../../react-ui/src/components/Entity/MissingFields.tsx) | 9.7 KB | Shows metadata fields missing from a layout |
| [MultiSelectAddDialog/](../../../react-ui/src/components/Entity/MultiSelectAddDialog/) | — | Multi-entity add dialog |
| [PolicySettings.tsx](../../../react-ui/src/components/Entity/PolicySettings.tsx) | 2.7 KB | AVP policy toggle per entity |
| [QuickAddPaymentTerm.tsx](../../../react-ui/src/components/Entity/QuickAddPaymentTerm.tsx) | 16 KB | Bespoke quick-add for payment terms |
| [ValidationFloater.tsx](../../../react-ui/src/components/Entity/ValidationFloater.tsx) | 14 KB | Tooltip/floater that surfaces field validation errors |
| [ValueList/](../../../react-ui/src/components/Entity/ValueList/) | — | LOV (list-of-values) management folder |
| [dialogForm.tsx](../../../react-ui/src/components/Entity/dialogForm.tsx) | 5.9 KB | Thin wrapper that drives dialog modes (add/edit/view) |
| **[dialogFormTemplate.tsx](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx)** | **116 KB** | **The generic form renderer.** Reads a `formLayout` from metadata, renders accordion sections, dispatches per-field JSX based on `editType` string. |
| [dialogFormTemplateSubscription.tsx](../../../react-ui/src/components/Entity/dialogFormTemplateSubscription.tsx) | 1.3 KB | GraphQL subscription wrapper for the dialog |
| [entityForm.tsx](../../../react-ui/src/components/Entity/entityForm.tsx) | 37 KB | Stand-alone form (outside dialog) for entity CRUD |
| **[entityManager.tsx](../../../react-ui/src/components/Entity/entityManager.tsx)** | **249 KB** | The core entity-management hook + types. Defines the `Metadata` interface (incl. `formLayout`, `addRecordFormLayout`, `editRecordFormLayout`, `tabLayout`, `sideLayout`, `layouts`). Consumes `formLayout` at runtime. |
| [sfAccordion.tsx](../../../react-ui/src/components/Entity/sfAccordion.tsx) | 8 KB | Syncfusion accordion wrapper |
| [sfForm.tsx](../../../react-ui/src/components/Entity/sfForm.tsx) | 2.7 KB | Simple sf-form wrapper |
| [sfGrid.tsx](../../../react-ui/src/components/Entity/sfGrid.tsx) | 196 KB | Generic Syncfusion grid + editing logic |
| [sfInPlaceEditor.tsx](../../../react-ui/src/components/Entity/sfInPlaceEditor.tsx) | 53 KB | In-grid inline cell editor |
| [sfSpreadsheet.tsx](../../../react-ui/src/components/Entity/sfSpreadsheet.tsx) | 117 KB | Excel-like spreadsheet entry mode |

### `react-ui/src/views/pages/Administration/` (admin tabs)

| Folder / file | What it does |
|---|---|
| [AdminTourComponents/](../../../react-ui/src/views/pages/Administration/AdminTourComponents/) | Interactive-tour UI for admin onboarding |
| [CompanySetup/](../../../react-ui/src/views/pages/Administration/CompanySetup/) | Tenant-level company settings |
| [Counters/](../../../react-ui/src/views/pages/Administration/Counters/) | Auto-incrementing counter management |
| [Groups/](../../../react-ui/src/views/pages/Administration/Groups/) | Cognito group / role management |
| [Import/](../../../react-ui/src/views/pages/Administration/Import/) | Bulk-data import wizard (8 files — ColumnMapping, Preview, etc.) |
| [NotificationSubscribers/](../../../react-ui/src/views/pages/Administration/NotificationSubscribers/) | Notification subscriber CRUD |
| [Policies/](../../../react-ui/src/views/pages/Administration/Policies/) | AVP policy CRUD UI |
| [Users/](../../../react-ui/src/views/pages/Administration/Users/) | Cognito user management |
| [ValueListGroups/](../../../react-ui/src/views/pages/Administration/ValueListGroups/) | LOV (list-of-values) group management |
| [index.tsx](../../../react-ui/src/views/pages/Administration/index.tsx) | Tab container |

### Answer — "which is a layout designer, form builder, or screen editor?"

**None of them.** `EntityBuilder.tsx` is an *entity-metadata schema* editor (attributes, types, options, flags). It auto-generates a default `formLayout` but does not let the admin drag fields, reorder sections, or add conditional visibility.

No file named `LayoutBuilder`, `FormBuilder`, `ScreenDesigner`, `ScreenEditor`, or anything similar.

---

## 2. Drag-and-drop library imports in `react-ui`

Search pattern: `from ['"](react-dnd|@dnd-kit|react-beautiful-dnd|react-grid-layout|@craftjs)`

**Result: `No files found`.**

**No drag-and-drop primitive is installed or imported anywhere in react-ui.** A designer built today would need to add `dnd-kit` (or equivalent) as a new dependency.

---

## 3. `layoutBuilder` / `formBuilder` / `screenDesigner` / `layoutEditor` string search

Case-insensitive search over `react-ui`:

**Result: `No matches found`.**

Similar search for `Designer` as a broader string returned hits only for `EntityBuilder.tsx` and admin-tab "Designer"-free filename fragments (UserSearch, CounterFilter etc.). No designer surface of any kind.

---

## 4. Field-type dispatch in `dialogFormTemplate.tsx` — quoted evidence

`getDialogElement()` begins at [dialogFormTemplate.tsx:1517](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517). All 10 type branches, each a hand-written Syncfusion component JSX block:

| editType | Line | Component instantiated |
|---|---|---|
| `multi-select` | 1523 | `MultiSelectComponent` (Syncfusion) |
| `dropdown`     | 1610 | `DropDownListComponent` |
| `list`         | 1830 | `EntityContents` (nested grid) |
| `object`       | 1956 | `EntityContents` |
| `date`         | 2079 | `DatePickerComponent` |
| `file`         | 2115 | `UploaderComponent` |
| `number`       | 2330 | `NumericTextBoxComponent` |
| masked-text    | 2388 | `MaskedTextBoxComponent` (branch inside `else`) |
| `textarea`     | 2484 | `TextAreaComponent` |
| text (default) | 2572 | `TextBoxComponent` |

Example of the dispatch shape ([dialogFormTemplate.tsx:1521-1524, 1610-1611, 1830-1831](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1521-L1524)):

```tsx
let editTemplate;

if (columnData['editType'] === 'multi-select') {
  editTemplate = (allowEditing: boolean = true) => {
    return (
      <div>
        <MultiSelectComponent
          id={columnData.field}
          cssClass={requiredClass}
          placeholder={columnData.headerText}
          floatLabelType="Always"
          showSelectAll={true}
          mode="CheckBox"
          fields={{ text: 'text', value: 'value' }}
          dataSource={ ... }
          change={ ... }
          ref={ ... }
          allowFiltering={true}
          enabled={allowEditing}
          showClearButton={true}
        > ... </MultiSelectComponent>
      </div>
    );
  };
} else if (columnData['editType'] === 'dropdown') {
  editTemplate = (allowEditing: boolean = true) => {
    return ( ... <DropDownListComponent ... /> ... );
  };
} else if (columnData['editType'] === 'list') {
  editTemplate = (allowEditing: boolean = true) => {
    return ( ... <EntityContents ... /> ... );
  };
} // ... and so on for date / file / number / masked / textarea / text
```

**Verdict on schema-driven vs hard-coded:**
- **Schema-driven (good):** which branch is taken is chosen by `columnData.editType`, a string read from metadata. Placeholder, required, options, refEntity, allowFreeText, decimalPlaces all flow from metadata.
- **Code-driven (gap):** the JSX *inside* each branch is hand-written. Each branch references a specific Syncfusion component by name. The callbacks (`change`, `ref`, `filtering`, `footerTemplate`) hard-code per-type behaviour (~300 lines for the dropdown branch alone). Adding a new field type, say `signature` or `richtext`, requires editing `getDialogElement()` and touching Syncfusion imports.

**Mixed, leaning code-driven.** The *selection* is schema-driven but the *rendering vocabulary* is bounded by whatever branches the developer already wrote. A tenant admin cannot add a new renderable field type without a code change.

---

## 5. `Metadata` interface in `entityManager.tsx` — quoted definition

From [entityManager.tsx:194-225](../../../react-ui/src/components/Entity/entityManager.tsx#L194-L225):

```ts
export interface Metadata {
  entityName: UpperSnakeCase;
  attributes: Record<CamelCase, AttributeMetadata>;
  IDGeneration?: { Attribute: string | string[]; Method: string };
  entityParameters?: {
    useStatus: boolean;
    editOnDefinitions?: boolean;
    useAvp?: boolean;
    extractionEntity?: boolean;
    headerEntity?: boolean;
    includeHeaderData?: boolean;
  };
  formLayout?: FormLayout[];
  defaultGridLayout?: FormLayout[];
  tabLayout?: TabLayout[];
  sideLayout?: SideLayout[];
  layouts?: { layoutName: string; layout: FormLayout[] }[];
  addRecordFormLayout?: FormLayout[];
  editRecordFormLayout?: FormLayout[];
  referentialConstraints?: Record<CamelCase, ReferentialConstraints> | string;
  entityStates?: Record<string, EntityState>;
  lovs?: Record<string, Lov>;
  dependentFields?: {
    field: CamelCase;
    operator: 'EQ' | 'LT' | 'GT';
    dependentTo: CamelCase | CamelCase[];
    entityName?: UpperSnakeCase;
  }[];
  detailEntities?: Record<UpperSnakeCase, DetailEntity>;
  // gsi fields
  [key: CamelCase]: string;
}
```

Layout-relevant fields: `formLayout`, `defaultGridLayout`, `tabLayout`, `sideLayout`, `layouts`, `addRecordFormLayout`, `editRecordFormLayout`.

### Does any field describe per-tenant or per-user layout customisation?

**Per-tenant: yes, implicitly.** The `Metadata` object is fetched per tenant from DynamoDB — every tenant has its own row keyed `T#{tenantId}#METADATA#ENTITY / ENTITY#{entityName}` ([create_entity_metadata.py:135-136](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L135-L136)). When the admin calls `EntityBuilder`, the resulting `formLayout` is stored on that tenant's metadata item and rendered only for that tenant.

**Per-user: no.** There is no `userLayout`, `userOverride`, or similar field in the interface.

### Is there a runtime code path that reads layout overrides from metadata?

**Yes — confirmed runtime consumption, not just types.** From [entityManager.tsx:1155-1171](../../../react-ui/src/components/Entity/entityManager.tsx#L1155-L1171):

```ts
} else if (metadataCurrent?.formLayout) {
  const orderedKeys = [
    // First add fields from gridFields in their specified order
    ...metadataCurrent.formLayout.flatMap((layout) =>
      layout.fields.flatMap((fieldGroup) => fieldGroup)
    ),
    // Then add remaining fields that weren't in gridFields
    ...(keys as CamelCase[]).filter(
      (key) =>
        !metadataCurrent.formLayout
          ?.flatMap((layout) =>
            layout.fields.flatMap((fieldGroup) => fieldGroup)
          )
          ?.includes(key)
    ),
  ];
  keys = orderedKeys as CamelCase[];
}
```

A second consumer is `parseLayouts` imported from [src/utils/entity.jsx:843](../../../react-ui/src/utils/entity.jsx#L843), called at [entityManager.tsx:5351](../../../react-ui/src/components/Entity/entityManager.tsx#L5351) and [entityManager.tsx:6868](../../../react-ui/src/components/Entity/entityManager.tsx#L6868) and also from [src/views/pages/Crm/Contracts/Tabs/Amendments/index.tsx:287](../../../react-ui/src/views/pages/Crm/Contracts/Tabs/Amendments/index.tsx#L287). The commented-out block at [entityManager.tsx:5612-5680](../../../react-ui/src/components/Entity/entityManager.tsx#L5612-L5680) shows an earlier in-component parser that has been moved into `utils/entity.jsx`.

**EntityBuilder writes a formLayout back to metadata on save** — [EntityBuilder.tsx:841-863](../../../react-ui/src/components/Entity/EntityBuilder.tsx#L841-L863):

```ts
// Generate form layout
const generateFormLayout = (attributeKeys: string[]) => {
  const systemFieldKeys = ['id', 'createdby', 'createddate'];
  const userFields = attributeKeys.filter(
    (key) => !systemFieldKeys.includes(key)
  );

  return [
    {
      collapsed: false,
      title: 'Basic Information',
      fields: [
        userFields.slice(0, 3),
        userFields.slice(3, 5),
        userFields.slice(5, 7),
      ].filter((row) => row.length > 0),
    },
    {
      title: 'System Fields',
      fields: [['createdBy'], ['createdDate']],
      collapsed: true,
    },
  ];
};
```

And at [EntityBuilder.tsx:1034](../../../react-ui/src/components/Entity/EntityBuilder.tsx#L1034) the generated layout is persisted alongside the entity definition:

```ts
formLayout: generateFormLayout(Object.keys(transformedAttributes)),
```

So the pipeline is: **admin defines attributes → `EntityBuilder` auto-generates a 3-section `formLayout` → saved to the tenant's metadata row → `dialogFormTemplate` consumes it at render time.** This is substantially more than v1 credited.

---

## 6. GraphQL / backend resolver support for tenant layout descriptors

Searched `src/resolvers/` for `layout`, `ScreenDescriptor`, `formLayout`, `tenantLayout`.

**Only match:** [src/resolvers/tenant_data_exporter.py:26-29](../../../trackon-aws-backend/src/resolvers/tenant_data_exporter.py#L26-L29), which declares `formLayout`, `sideLayout`, `tabLayout`, `layouts` as part of the export field order:

```python
FIELD_ORDER = [
    "entityName",
    "IDGeneration",
    "pkFormula",
    "skFormula",
    "entityParameters",
    "entityStates",
    "workflowTriggers",
    "attributes",
    "referentialConstraints",
    "detailEntities",
    "formLayout",
    "sideLayout",
    "tabLayout",
    "layouts",
    "syncToParent",
    "syncFromParent",
    "lovs",
]
```

This dumps the whole tenant metadata (including layouts) to `s3://{bucket}/metadata/{tenant_id}/metadata_dump.json`. Counterpart [src/resolvers/tenant_data_loader.py](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py) handles re-import. Primitive snapshot-and-restore, not a layout designer.

**No dedicated `create_screen_descriptor` / `update_screen_descriptor` / `getLayout` resolver** and no matching GraphQL mutation. Layouts travel inside the generic `createEntityMetadata` / `updateEntityMetadata` (upsert) path documented in the B1 correction.

---

## 7. Revised B2 gap statement

**The original claim is partially refuted on structure, confirmed on designer UX.**

The runtime-layout machinery exists and is already metadata-driven: `formLayout`, `addRecordFormLayout`, `editRecordFormLayout`, `tabLayout`, `sideLayout`, and `layouts` are all declared in the `Metadata` interface, read at render time by `entityManager.tsx`, and persisted per-tenant through the same upsert path as other entity metadata. `EntityBuilder` auto-populates a default `formLayout` when a new entity is created, and `tenant_data_exporter`/`loader` can snapshot and restore the whole thing to S3. What is genuinely missing is (a) a visual designer for editing the layout (no drag-and-drop library installed, no `LayoutBuilder`/`ScreenDesigner` component), (b) richer descriptor features — conditional visibility, action buttons, field-level RBAC — that the current `FormLayout` shape doesn't carry, and (c) extensible field-type rendering — the 10-branch editType dispatch in `dialogFormTemplate.tsx` is hand-written Syncfusion JSX per type, so adding a new field type remains a code change. The blocker should be reworded from "build a screen designer end-to-end" to "design an extended `FormLayout` descriptor that covers conditional visibility + actions + RBAC, build a `dnd-kit`-based editor, and refactor the editType dispatch into a pluggable renderer registry". Effort estimate drops modestly: ~8–10 dev-weeks (was 11–14) because (a) the descriptor already exists and can be extended rather than invented, (b) the renderer-consumption path is already wired, (c) tenant storage/update is done.

**Confidence grade: Partially Confirmed.** The "no designer UI" and "hard-coded field rendering" claims hold; the "blocks point 3 entirely" claim is overstated — a tenant admin already gets a usable auto-layout per entity, just can't visually tailor it.
