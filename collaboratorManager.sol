pragma solidity ^0.5.12;

/// @title A multisig inspired git commit approver
/// @author Peter Altmann
/// @notice This contract is meant to showcase some basic options
/// @dev The setSigner function should be replaced with a proxy that calls a collaborator management contract, which returns address[] and superUser address.
contract gitMultiSig {
    uint signers;
    address[] notSigned;
    address[] hasSigned;
    mapping (address => bool) public signList;
    mapping (address => bool) public signedList;
    bool public superUserSigned;

    modifier testSigner() {
        require (!signList[msg.sender]);
        _;
    }
    modifier testSigned() {
        require (!signedList[msg.sender]);
        _;
    }
    
    function setSigner() testSigner public {
        /// @notice since we do not import "mapping (address => colaboratorStruct) collaborators", we need a way to create a list of collaborators.
        /// @param signList Solidity cannot loop through arrays, so we need to create a mapping to be able to check if someone is already registered.
        /// @param notSigned is an address array with addresses who have not yet signed off on the git commit.
        /// @param signers countes total number of signers.
        signList[msg.sender] = true;
        notSigned.push(msg.sender);
        signers ++;
    }

    function getNotSigned() public view returns(address[] memory, uint hasCount){
        /// @return array of addresses who have not yet signed the git commit
        return (notSigned, signers - hasSigned.length);
    }

    function getHasSigned() public view returns(address[] memory, uint hasCount){
        /// @return array of addresses who have signed the git commit
        /// @param hasSigned address array with addresses who have signed off on the git commit.
        return (hasSigned, hasSigned.length);
    }
    
    function createSignature() public testSigned returns(string memory Vote){
        /// @notice checks for implements a simple counter for the m of n part; adds signer to hasSigned; deletes the index of the signer;
        /// @dev deletion in Solidity sets memory address associated with index to 0x00...0. Other removal mechanism exists, but delete is most simple.
        /// @dev signList[address] == true; can be an alternative to for loop but introduces delete problems. Internal function call can be an alternative.
        /// @dev no check implemented for trying to create multiple signatures.
        /// @returns vote outcome
        require (signList[msg.sender]);
        signedList[msg.sender] = true;
        for (uint i = 0; i < notSigned.length; i++) {
            if (msg.sender == notSigned[i]) {
                hasSigned.push(msg.sender);
                delete notSigned[i];
                return (" casted");
            }
            else continue;
        }
    }

    function createSuperUserSignature() public {
        /// @notice sets a signature from a superuser, i.e., a user with priveleges. For illustrative purposes the superuser address check always evaluates as true.
        /// @param superUserSigned is a bool that
        superUserSigned = (msg.sender == msg.sender);
    }

    function gitMultiSigCommit(uint _m) public view returns(bool gitCommitted) {
        /// @notice function performs an m of n test OR a super user signed test. if _m == signers then that means that everyone has to sign.
        return ((_m <= hasSigned.length) || superUserSigned);
    }
}
