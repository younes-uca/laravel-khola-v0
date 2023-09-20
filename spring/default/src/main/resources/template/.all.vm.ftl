<!DOCTYPE html>
<html>
<head>
    <title>Invoice</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 18px;
            line-height: 1.5;
            margin: 0;
            padding: 0;

        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            border: 1px solid #ccc;
            background-color: #fff;
            box-shadow: 0 0 10px #ddd;
        }

        .header {
            text-align: left;
            margin-bottom: 20px;
        }

        .header h1 {
            font-size: 35px;
            font-weight: bold;
            margin: 0;
            color: #c9302c;
        }

        .company-info {
            margin-bottom: 20px;
        }

        .company-info p {
            margin: 0;
            line-height: 1.5;
        }

        .invoice-details {
            margin-bottom: 20px;
        }

        .invoice-details p {
            margin: 0;
            line-height: 1.5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            height: 40px;
            text-align: left;
            font-size: 17px;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        th {
            font-weight: bold;
        }

        .totals {
            margin-top: 20px;
            text-align: left;
        }

        .totals p {
            margin: 0;
            line-height: 1.5;
        }

        .footer {
            text-align: center;
        }

        .footer p {
            margin: 0;
            line-height: 1.5;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="header" style="font-family: Noto Sans JP, sans-serif;">
        <h1>REÇU</h1>
    </div>
    <br/>
    <hr style="color:#c9302c ;height: 3px"></hr>
    <br/>

    #macro(displayComposedDataIfNotNull $object $dataToDisplay)
    #if($object)$dataToDisplay#else---#end
    #end
    #macro(displayDataIfNotNull $object)
    #if($object)$object#else---#end
    #end
    <table style="width: 100%">

        <#list pojo.fields as field>
            <#if field.simple && !field.notVisibleInCreatePage>
                <#if field.id == false && field.large == false>
                <tr>
                    <td style="text-align: left;border-bottom: 0"><span style="font-weight: bold;">${field.formatedName?cap_first}:</span> #displayDataIfNotNull($${field.name})</td>
                </tr>
                </#if>
            <#elseif field.generic>
                <tr>
                    <td style="text-align: left;border-bottom: 0"><span style="font-weight: bold;">${field.formatedName?cap_first}:</span> #displayComposedDataIfNotNull($${field.name},$${field.name}.${field.typeAsPojo.labelOrReferenceOrId.name})</td>
                </tr>
            </#if>
        </#list>

    </table>
    <br/><br/><br/><br/><br/>
    <#if pojo.hasList>
        <#list pojo.fields as field>
            <#if field.list && (field.associationComplex || field.fakeAssociation)>
    <h1>${field.formatedName?cap_first}</h1>
    <table>
        <thead>
            <tr>
    <#list field.typeAsPojo.fields as innerField>
        <#if (innerField.simple && innerField.id == false) || (innerField.generic && innerField.typeAsPojo.name != pojo.name) >
                <th>${innerField.formatedName?cap_first}</th>
        </#if>
    </#list>
            </tr>
        </thead>
        <tbody>
                #foreach( $item in $${field.name} )
                #if( ($foreach.index % 2) == 0 )
                <tr style="background-color: #f4f5f6">
                    #else
                <tr style="background-color: #e9ebec">
                    #end
                    <#list field.typeAsPojo.fields as innerField>
                        <#if innerField.simple && innerField.id == false>
                    <td>#displayDataIfNotNull($item.${innerField.name})</td>
                        <#elseif innerField.generic && innerField.typeAsPojo.name != pojo.name>
                    <td>#displayDataIfNotNull($item.${innerField.name},$item.${innerField.name}.${innerField.typeAsPojo.labelOrReferenceOrId.name})</td>
                        </#if>
                    </#list>
                </tr>
                #end
        </tbody>
    </table>
            </#if>
    </#list>
    </#if>
    <br/><br/>

    <div class="footer">
        <p style="font-size: 25px">MERCI POUR VOTRE SERVICE!</p>
        <p style="font-size: 18px">Si vous avez des questions, veillez contacter nous.</p>
    </div>
    <br/><br/>
    <hr style="color:#c9302c ;height: 3px"></hr>
</div>
</body>
</html>

