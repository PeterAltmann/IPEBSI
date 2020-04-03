# Guides

## Apps

- [Build an IPFS app with Node.js](https://www.youtube.com/watch?v=RMlo9_wfKYU)
- [Interactive tutorials for IPFS](https://proto.school/#/tutorials)

# Data structures

Defined as "a collection of data values, the relationships among them, and the functions or operations that can be applied to the data."

Data structures for decentralized systems need to be:

- verifiable if they are to work in a zero trust environment
- linked together in a web of interlinked data
- cannot use location addressing because LAS (location addressed storage)
  1. relies on central authorities for data hosting
  2. does not allow us to verify data
  3. when looking for a file, we cannot determine the domain or the filename.

## Content addressable storage (CAS)

**Cryptographic** hashing is used to create unique and verifiable links to data. It forms the basis of the decentralized data structures that IPLD and IPFS is based on. A file, e.g., `cat.jpg` deterministically generates a digest `zdpuAsHkamdCQgrDrNSwJVgjMkQWoLxdrccxV6qe9htipNein`that acts as the file's unique identifier. A decentralized web protocol like IPFS can then use that unique identifier to find a file. We care not who sent the file to us, since the unique digest guarantees that the file is what we requested. File request are broadcasted to the entire network using these unique digests. 

## Content identifiers (CID)

We need a way to know what data format we are working with. A CID is a content addressing form used by IPLD. A CID contains both a **cryptographic hash digest** of a certain file, as well as a [**codec**](https://github.com/multiformats/multicodec) that tells us how to interpret the associated data.

A CID in IPLD contains the Codec (helps us interpret that data) and the [Multihash](https://github.com/multiformats/multihash) (a hash digest that contains information about what type of hashing function was used to create the given digest) of an object. Using CID, we have a universal identifier for all kinds of formats and protocols that rely on content addressing, e.g., Git and Ethereum.

