# Syntax

Inspired from:
- https://moz.com/blog/writing-structured-data-guide
- https://www.w3.org/TR/json-ld11/

## Curly braces

```
{
<content>
}
```

Curly bracers contain structured data.

## Quotation marks

```
{
  "<schema type/property>": "<information>"
}
```

When [schema types or schema properties](https://schema.org/docs/schemas.html) are called, or when fields are filled in, 
the information is wrapped in quotation marks. Colons, i.e., `:`, act as field seperator between type/property and 
the information. 

## Commas

```
{
  "<schema type/property>": "<information>",
  "<schema type/property>": "<information>",
  ...
}
```

Commas are used to indicate that more information is coming.

## Brackets 

```
{
  "<schema type/property>": "<information>",
  "<schema type/property>": "<information>",
  "sameAs": ["URL1", "URL2"]
}
```

Brackets are used when a [schema property](https://schema.org/Property) is called that contains two or more entries.

## Inner curly brackets

```
{
  "<schema type/property>": "<information>",
  "<schema type/property>": "<information>",
  "sameAs": ["URL1", "URL2"]
  "contactPoint": {
    "@type": "ContactPoint"
    "telephone: "0702 - 08 29 32"
  }
}
```

When a *property* has an expected type (e.g., https://schema.org/contactType) then the inner curly bracers are used 
to enclose that information. Note that schema types and schema properties can have similar names and are case sensitive, 
[contactPoint](https://schema.org/contactPoint) != [ContactPoint](https://schema.org/ContactPoint).

## Properties with multiple expected types

```
{
  "<schema type/property>": "<information>",
  "<schema type/property>": "<information>",
  "sameAs": ["URL1", "URL2"]
  "contactPoint": {
    "@type": "ContactPoint"
    "telephone: "0702 - 08 29 32"
  },
  "address": {
    "@type": "PostalAddress",
    "postalCode": "16343"
  }
}
```

The property address, has expected types "PostalAddress" or "Text". Whenever possible, specify the type.

## Complex arrays

```
{
  "<schema type/property>": "<information>",
  "<schema type/property>": "<information>",
  "sameAs": ["URL1", "URL2"]
  "contactPoint": {
    "@type": "ContactPoint"
    "telephone: "0702 - 08 29 32"
  },
  "address": [
    {
      "@type": "PostalAddress",
      "postalCode": "16343"
    },
    {
      "@type": "PostalAddress",
      "postalCode": "16348" 
    }
  ]
}
```

An array can contain multiple entries for a single property.

## Node arrays using @graph

@graph calls an array just like the complex array example above. One important property contained within is the "@id" one. 
This is more for SEO and is not so relevant for the IPEBSI use case.
