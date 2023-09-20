{
    "from-to": "Elements from {first} to {last} (total {totalRecords})",
    "new" : "Nouveau",
    "search": "Chercher",
    "export": "Exporter",
    "validate": "Validater",
    "search": "Chercher...",
    "delete": "Supprimer",
    "cancel": "Annuler",
    "save": "Sauvgarder",
    "next": "Suivant",
    "yes": "Oui",
    "no": "Non",
    "actions": "Actions",
    "confirm": "Confirmer",
    "creation": "Creation",
    "list": "Liste",

<#list 0..pojos?size-1 as i>

    "${pojos[i].name?uncap_first}":{
    <#list 0..pojos[i].fields?size - 1 as j>
       <#if pojos[i].fields[j].id == false>
        "${pojos[i].fields[j].name18nCreateKey?uncap_first}": "${pojos[i].fields[j].name18nCreateValue}",
            <#if pojos[i].fields[j].nombre ||  pojos[i].fields[j].dateTime>
        "${pojos[i].fields[j].name18nMinCreateKey?uncap_first}": "${pojos[i].fields[j].name18nMinCreateValue}",
        "${pojos[i].fields[j].name18nMaxCreateKey?uncap_first}": "${pojos[i].fields[j].name18nMaxCreateValue}",
            </#if>
    </#if>
    <#if pojos[i].fields[j].generic == true>
        "${pojos[i].fields[j].name18nPlaceHolderCreateKey?uncap_first}": "Select a ${pojos[i].fields[j].name18nPlaceHolderCreateValue}",
        "${pojos[i].fields[j].name18nPlaceHolderFilterCreateKey?uncap_first}": "Search by ${pojos[i].fields[j].name18nPlaceHolderFilterCreateValue}",
    </#if>
        <#if pojos[i].fields[j].list && pojos[i].fields[j].association>
        "${pojos[i].fields[j].name18nPlaceHolderCreateKey?uncap_first}": "Select multiple ${pojos[i].fields[j].name18nPlaceHolderCreateValue}s",
        </#if>
</#list>
        "${pojos[i].name?uncap_first}": "${pojos[i].formatedName}",
        "${pojos[i].tabPanelI18nCreateKey?uncap_first}": "${pojos[i].tabPanelI18nCreateValue}",
        "${pojos[i].listHeaderI18nKey?uncap_first}": "${pojos[i].listHeaderI18nValue}",
        "delete${pojos[i].name}ConfirmationMessage": "Voulez vous vraiment supprimer ${pojos[i].formatedName?uncap_first}",
        "delete${pojos[i].name}sConfirmationMessage": "Voulez vous vraiment supprimer les elments selectionnes"

    },

</#list>
"appName": "GED"
}


