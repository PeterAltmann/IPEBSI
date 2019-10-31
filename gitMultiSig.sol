pragma solidity ^0.5.11;

/// @title A multisig inspired git commit approver
/// @author Peter Altmann
/// @notice This contract is meant to showcase some basic options
/// @dev The setSigner function should be replaced with a proxy that calls a collaborator management contract, which returns address[] and superUser address.
contract gitMultiSig {
    uint public signatures;
    address[] notSigned;
    address[] hasSigned;
    mapping (address => bool) signList;
    bool public superUserSigned;

    function setSigner() public {
        /// @notice since we do not import "mapping (address => colaboratorStruct) collaborators", we need a way to create a list of collaborators.
        /// @param signList Solidity cannot loop through arrays, so we need to create a mapping to be able to check if someone is already registered.
        /// @param notSigned is an address array with addresses who have not yet signed off on the git commit.
        if (signList[msg.sender] == true) {
            revert();
        }
        else {
            signList[msg.sender] = true;
            notSigned.push(msg.sender);
        }
    }

    function getNotSigned() public view returns(address[] memory){
        /// @return array of addresses who have not yet signed the git commit
        return notSigned;
    }

    function getHasSigned() public view returns(address[] memory){
        /// @return array of addresses who have signed the git commit
        /// @param hasSigned address array with addresses who have signed off on the git commit.
        return hasSigned;
    }

    function createSignature() public returns(string memory Vote){
        /// @notice checks for implements a simple counter for the m of n part; adds signer to hasSigned; deletes the index of the signer;
        /// @dev deletion in Solidity sets memory address associated with index to 0x00...0. Other removal mechanism exists, but delete is most simple.
        /// @dev signList[address] == true; can be an alternative to for loop.
        /// @dev no check implemented for trying to create multiple signatures.
        /// @param signatures is the counter.
        /// @returns vote outcome
        for (uint i = 0; i < notSigned.length; i++) {
            if (msg.sender == notSigned[i]) {
                signatures ++;
                hasSigned.push(msg.sender);
                delete notSigned[i];
                return (" casted");
            }
            else continue;
        }
        return (" not casted");
    }

    function createSuperUserSignature() public {
        /// @notice sets a signature from a superuser, i.e., a user with priveleges. For illustrative purposes the superuser address check always evaluates as true.
        /// @param superUserSigned is a bool that
        if (msg.sender == msg.sender) superUserSigned = true;
    }

    function gitMultiSigCommit(uint _m) public view returns(bool gitCommitted) {
        /// @notice function performs an m of n test OR a super user signed test. if _m == hasSigned.lenth then that means that everyone has to sign.
        if (_m <= hasSigned.length || superUserSigned == true) {
            return true;
        }
        else {
            return false;
        }
    }
}
