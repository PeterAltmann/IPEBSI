pragma solidity ^0.5.12;

/// @title collaboratorManager
/// @notice this contract manages a list of collaborators for a project
contract collaboratorManager {
    
    address superOwner;
    constructor() public {
        superOwner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == superOwner);
        _;
    }
    
    /// @param organization is the name of the collaborator's organization
    /// @param fName is first name of collaborator representative
    /// @param lName is last name of collaborator representative
    /// @param listPointer is the index of the entityList variables
    /// @param entityStructs maps the addresses of the collaborators with the EntityStruct information
    /// @param entityList is the set of all collaborators
    struct EntityStruct {
        string organization;
        string fName;
        string lName;
        uint listPointer;
    }
    mapping(address => EntityStruct) public entityStructs;
    address[] public entityList;
    
    /// @notice creates a new collaborator unless a collaborator address already is registered
    function newEntity(address _address, string memory organization, string memory fName, string memory lName) public payable returns(bool creationSuccess){
        if(isEntity(_address)) revert();
        entityStructs[_address].organization = organization;
        entityStructs[_address].fName = fName;
        entityStructs[_address].lName = lName;
        entityStructs[_address].listPointer = entityList.push(_address) - 1;
        return true;
    }

    /// @notice updates an existing collaborator unless an unregistered address is specified
    function updateEntity(address _address, string memory organization, string memory fName, string memory lName) public payable returns(bool updateSuccess) {
        if (!isEntity(_address)) {
            revert();
        }
        else if (msg.sender != _address && msg.sender != superOwner) {
            revert();
        }
        entityStructs[_address].organization = organization;
        entityStructs[_address].fName = fName;
        entityStructs[_address].lName = lName;
        return true;
    }

    /// @notice deletes an existing collaborator
    /// @dev the function works by overwriting the address to be deleted with the address at the end of the list and then reducing the list size by 1
    function deleteEntity(address _address) public payable returns(bool deleteSuccess) {
        if(!isEntity(_address)) revert();
        uint rowToDelete = entityStructs[_address].listPointer;
        address keyToMove = entityList[entityList.length-1];
        entityList[rowToDelete] = keyToMove;
        entityStructs[keyToMove].listPointer = rowToDelete;
        entityList.length--;
        return true;
    }
    
    /// @dev we can return the entityList to another contract if we want to make this into a proxy contract
    function getCollaborators() public view returns(address[] memory){
        return entityList;
    }

    function isEntity(address _address) public view returns(bool entityExists) {
        if(entityList.length == 0) return false;
        return (entityList[entityStructs[_address].listPointer] == _address);
    }

    function getEntityCount() public view returns(uint entityCount) {
        return entityList.length;
    }
    
}
