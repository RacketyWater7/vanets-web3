// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract Vanets{
    address public admin;
    // to store the data that is not on urgent demand, we use IPFS and then store IPFS hash inside the respective node, for reducing the data load on blockchain    
    // to store on-demand data, we store on blockchain, inside respective nodes
    mapping(uint256 => Node) nodes;
    struct Node {
        uint256 node_id;
        string[] node_velocity;
        string[] node_type;
        string[] IPFShashForNotOnDemand;
    // An IPFS hash can be like "QmXgm5QVTy8pRtKrTPmoWPGXNesehCpP4jjFMTpvGamc1p";
    }
    // Enums
    enum contractState {NotReady, Created}
    contractState public contState; 
    // Modifiers
    modifier OnlyAdmin{
        require(msg.sender == admin);
        _;
    }
    //Events
    event ContractCreated(address owner, string info);

    constructor() payable {
      admin = msg.sender;
      contState = contractState.NotReady;
    }

    // Functions

    function createContract() OnlyAdmin public {
      require(contState == contractState.NotReady);
      contState = contractState.Created;
      emit ContractCreated(msg.sender, "Smart Contract created by Admin.");
    }
    // Create a new node.
    function newNode(uint256 _id) public {
        require(contState == contractState.Created && msg.sender == admin);
        nodes[_id].node_id = _id;
    }
    // storing on Demand data
    function addDataToNode(uint256 _id, string memory _velocity, string memory _node_type, string memory _IPFShash) public{
        require(contState == contractState.Created && msg.sender == admin);
        nodes[_id].node_velocity.push(_velocity);
        nodes[_id].node_type.push(_node_type);
        nodes[_id].IPFShashForNotOnDemand.push(_IPFShash);
    }
    // storing on demand data in a repective node by index
    function setDataToNode(uint256 _id, uint256 _index, string memory _newVelocity, string memory _newNodeType, string memory _newIPFShash) public{
        require(contState == contractState.Created && msg.sender == admin);    
        nodes[_id].node_velocity[_index] = _newVelocity;
        nodes[_id].node_type[_index] = _newNodeType;
        nodes[_id].IPFShashForNotOnDemand[_index] = _newIPFShash;
    }
    // getting respective node's velocity
    function getNodeVelocity(uint256 _id, uint256 _velocityIndex) public view returns(string memory){
        require(contState == contractState.Created && msg.sender == admin);
        return nodes[_id].node_velocity[_velocityIndex];
    }
    // getting respective node's type
    function getNodeType(uint256 _id, uint256 _nodeTypeIndex) public view returns(string memory){
        require(contState == contractState.Created && msg.sender == admin);
        return nodes[_id].node_type[_nodeTypeIndex];
    }
    // getting respective node's IPFS Hash value
    function getIPFShash(uint256 _id, uint256 _IPFShashIndex) public view returns(string memory){
        require(contState == contractState.Created && msg.sender == admin);
        return nodes[_id].IPFShashForNotOnDemand[_IPFShashIndex];
    }
}
