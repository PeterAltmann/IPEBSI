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

We need a way to know what data format we are working with. A [CID](https://proto.school/#/anatomy-of-a-cid) is a content addressing form used by IPLD. A CID contains both a **cryptographic hash digest** of a certain file, as well as a [**codec**](https://github.com/multiformats/multicodec) that tells us how to interpret the associated data.

A CID in IPLD contains the Codec (helps us interpret that data) and the [Multihash](https://github.com/multiformats/multihash) (a hash digest that contains information about what type of hashing function was used to create the given digest) of an object. Using CID, we have a universal identifier for all kinds of formats and protocols that rely on content addressing, e.g., Git and Ethereum.

Using CIDs, we can build data structures that link to other data structures in different formats (e.g., JSON, git commits, Ethereum transaction data etc.).

Text

## Merkle trees and Directed Acyclic Graphs
A Merkle tree is a data structure where every node is hashed and linked together using these hashes. A root node is uniquely linked to the data in all the leaf nodes (read more [here](https://en.wikipedia.org/wiki/Merkle_tree)). Relatedly, [Directed Acyclic Graphs](https://en.wikipedia.org/wiki/Directed_acyclic_graph) is a specific type of a Merkle tree where different branches in the tree can point at other branches in a single direction (hence directed) without ever pointing to a previous node (hence acyclic). 

# Interplanetary File System (IPFS)

IPFS is a P2P networking protocol used to share data on the decentralized web. You can get started by following [this guide](https://docs.ipfs.io/introduction/usage/).

## Interacting with files

Each peer can host whatever data they want locally. You can install IPFS on your own computer and create a new instance, i.e., a node, there that can host and store your data. These data can then be accessed using the CID. Using the [Files API](https://github.com/ipfs/interface-js-ipfs-core/blob/master/SPEC/FILES.md#the-files-api-aka-mfs-the-mutable-file-system) it is possible to work with files as you normally would in a name-based filesystem. The updating of links and hashes is done automatically and is abstracted away from the user.

To check the status of the root folder, you can do the following.

```javascript
const run = async () => {
  return await ipfs.files.stat('/')
}

return run
```

The above command can also be run from the terminal, which is shown below together with its output.

```bash
$ ipfs files stat /
QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn
Size: 0
CumulativeSize: 4
ChildBlocks: 0
Type: directory
```

