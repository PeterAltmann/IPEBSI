# JSON-LD

- A JSON-LD describes an edge-labeled directed graph data model.
- The graph contains vertices connected by directed edges.
- Each vertice is either a resource (things/entities in the world) with properties, or the data values of those properties.
- Vertices are resources.
- Unnamed nodes, i.e., "blank nodes," are those not identified by an [IRI](https://tools.ietf.org/html/rfc3987#section-2).
- [Literals](https://www.w3.org/TR/rdf11-concepts/#dfn-literal) are considered resources.
- Node objects represent zero or more properties of a node in a graph.
- Conformance information [found here](https://www.w3.org/TR/json-ld11/#conformance).
- Linked data uses IRIs [(Internationalized Resource Identifiers)](https://www.w3.org/TR/json-ld11/#basic-concepts) for unambiguous identifiers to data. 
- Using an IRI, we can go to a source to get a definition of the term (aka IRI dereferencing).

## JSON vs JSON-LD

```
{
  "name": "Manu Sporny",
  "homepage": "http://manu.sporny.org/",
  "image": "http://manu.sporny.org/images/manu.png"
}
```

The above is a JSON document. 

```
{
  "http://schema.org/name": "Manu Sporny",
  "http://schema.org/url": {
    "@id": "http://manu.sporny.org/"
    ↑ The '@id' keyword means 'This value is an identifier that is an IRI'
  },
  "http://schema.org/image": {
    "@id": "http://manu.sporny.org/images/manu.png"
  }
}
```

The example above is a JSON-LD. Here, each property is unambiguously identified using IRI, and all values representing IRIs are marked using `@id`. 

### Context

To avoid verbose descriptions, JSON-LD uses a [context](https://www.w3.org/TR/json-ld11/#the-context) to map terms to IRIs.

```
{
  "@context": {
    "name": "http://schema.org/name",
    ↑ This means that 'name' is shorthand for 'http://schema.org/name'
    "image": {
      "@id": "http://schema.org/image",
      ↑ This means that 'image' is shorthand for 'http://schema.org/image'
      "@type": "@id"
      ↑ This means that a string value associated with 'image'
        should be interpreted as an identifier that is an IRI
    },
    "homepage": {
      "@id": "http://schema.org/url",
      ↑ This means that 'homepage' is shorthand for 'http://schema.org/url'
      "@type": "@id"
      ↑ This means that a string value associated with 'homepage'
        should be interpreted as an identifier that is an IRI 
    }
  }
  "name": "<some name>",
  "homepage": "<some IRI, e.g., URL or doi or magnet link>",
  "image": "<some IRI, can be URL or doi or magnet link>"
}
```

The context can also be references using jsonld files as follows

```
{
  "@context": "https://json-ld.org/contexts/person.jsonld",
  "name": "Manu Sporny",
  "homepage": "http://manu.sporny.org/",
  "image": "http://manu.sporny.org/images/manu.png"
}
```


## Syntax tokens and keywords

Full details available [here](https://www.w3.org/TR/json-ld11/#syntax-tokens-and-keywords).

- `:` separator for key value pairs.
- `@base` defines the base IRI for the document
- `@container` sets default container type for a [term](https://www.w3.org/TR/json-ld11/#terms).
- `@context` defines short-hand names (i.e., [terms](https://www.w3.org/TR/json-ld11/#terms)) used throughout the JSON-LD document. Defined more in depth [here](https://www.w3.org/TR/json-ld11/#the-context).
- `@direction` WIP.
- `@graph` expresses a [graph](https://www.w3.org/TR/json-ld11/#named-graphs).
- `@id` used to uniquely identify node objects described in the document with IRIs or blank node identifiers. Desribed in detail [here](https://www.w3.org/TR/json-ld11/#node-identifiers).
- `@import` WIP.
- `@included` WIP.
- `@index` WIP.
- `@json` WIP.
- `@language` specifies language for particular string value or JSON-LD document.
- `@list` expresses an ordered set of data. Details [here](https://www.w3.org/TR/json-ld11/#lists).
- `@nest` WIP.
- `@none` WIP.
- `@prefix` WIP.
- `@propagate` WIP.
- `@protected` WIP.
- `@reverse` WIP.
- `@set` WIP.
- `@type` WIP.
- `@value` WIP.
- `@version` WIP.
- `@vocab` WIP.

# Guide

Inspired from:

- https://moz.com/blog/writing-structured-data-guide
- https://www.w3.org/TR/json-ld11/
- https://www.w3.org/TR/ld-glossary/
- http://xmlns.com/foaf/spec/
- https://www.w3.org/TR/rdf11-concepts/
- https://json-ld.org/playground/ (useful for testing final JSON-LD docs)
- https://search.google.com/structured-data/testing-tool (test the structured data)
- https://webcode.tools/json-ld-generator/software-application (generator)
- https://webcode.tools/json-ld-generator (generator)

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
