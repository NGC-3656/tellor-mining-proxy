pragma solidity >=0.4.22 <0.8.0;
import "./ChiGasSaver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface ITellor {
    function beginDispute(uint256 _requestId, uint256 _timestamp, uint256 _minerIndex) external;
    function vote(uint256 _disputeId, bool _supportsDispute) external;
    function tallyVotes(uint256 _disputeId) external;
    function proposeFork(address _propNewTellorAddress) external;
    function addTip(uint256 _requestId, uint256 _tip) external;
    function submitMiningSolution(string calldata _nonce,uint256[5] calldata _requestId, uint256[5] calldata _value) external;
    function proposeOwnership(address payable _pendingOwner) external;
    function claimOwnership() external;
    function depositStake() external;
    function requestStakingWithdraw() external;
    function withdrawStake() external;
    function approve(address _spender, uint256 _amount) external returns (bool);
    function transfer(address _to, uint256 _amount) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool);
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function getNewCurrentVariables() external view returns(bytes32 _challenge,uint[5] memory _requestIds,uint256 _difficutly, uint256 _tip);
    function getTopRequestIDs() external view returns(uint256[5] memory _requestIds);
    function getNewVariablesOnDeck() external view returns (uint256[5] memory idsOnDeck, uint256[5] memory tipsOnDeck);
    function updateTellor(uint _disputeId) external;
    function unlockDisputeFee (uint _disputeId) external;
    function allowance(address _user, address _spender) external view returns (uint256);
    function allowedToTrade(address _user, uint256 _amount) external view returns (bool);
    function balanceOf(address _user) external view returns (uint256);
    function balanceOfAt(address _user, uint256 _blockNumber) external view returns (uint256);
    function didMine(bytes32 _challenge, address _miner) external view returns (bool);
    function didVote(uint256 _disputeId, address _address) external view returns (bool);
    function getAddressVars(bytes32 _data) external view returns (address);
    function getAllDisputeVars(uint256 _disputeId) external view returns (bytes32, bool, bool, bool, address, address, address, uint256[9] memory, int256);
    function getCurrentVariables() external view returns (bytes32, uint256, uint256, string memory, uint256, uint256);
    function getDisputeIdByDisputeHash(bytes32 _hash) external view returns (uint256);
    function getDisputeUintVars(uint256 _disputeId, bytes32 _data) external view returns (uint256);
    function getLastNewValue() external view returns (uint256, bool);
    function getLastNewValueById(uint256 _requestId) external view returns (uint256, bool);
    function getMinedBlockNum(uint256 _requestId, uint256 _timestamp) external view returns (uint256);
    function getMinersByRequestIdAndTimestamp(uint256 _requestId, uint256 _timestamp) external view returns (address[5] memory);
    function getNewValueCountbyRequestId(uint256 _requestId) external view returns (uint256);
    function getRequestIdByRequestQIndex(uint256 _index) external view returns (uint256);
    function getRequestIdByTimestamp(uint256 _timestamp) external view returns (uint256);
    function getRequestIdByQueryHash(bytes32 _request) external view returns (uint256);
    function getRequestQ() external view returns (uint256[51] memory);
    function getRequestUintVars(uint256 _requestId, bytes32 _data) external view returns (uint256);
    function getRequestVars(uint256 _requestId) external view returns (string memory, string memory, bytes32, uint256, uint256, uint256);
    function getStakerInfo(address _staker) external view returns (uint256, uint256);
    function getSubmissionsByTimestamp(uint256 _requestId, uint256 _timestamp) external view returns (uint256[5] memory);
    function getTimestampbyRequestIDandIndex(uint256 _requestID, uint256 _index) external view returns (uint256);
    function getUintVar(bytes32 _data) external view returns (uint256);
    function getVariablesOnDeck() external view returns (uint256, uint256, string memory);
    function isInDispute(uint256 _requestId, uint256 _timestamp) external view returns (bool);
    function retrieveData(uint256 _requestId, uint256 _timestamp) external view returns (uint256);
    function totalSupply() external view returns (uint256);
}


contract TellorProxy is ChiGasSaver, Ownable {

  address tellorAddress;

  constructor(address _tellorAddress, address _gasToken) public {
    tellorAddress = _tellorAddress;
    gasToken = _gasToken;
  }

  function tokenWithdraw(address _tokenAddress, uint256 _amount) external onlyOwner {
    require(IERC20(_tokenAddress).transfer(msg.sender, _amount));
  }

  function addTip(uint256 _requestId, uint256 _tip)
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).addTip(_requestId, _tip);
  }

  function submitMiningSolution(string calldata _nonce, uint256 _requestId, uint256 _value)
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).submitMiningSolution(_nonce, _requestId, _value);
  }

  function depositStake()
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).depositStake();
  }

  function requestStakingWithdraw()
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).requestStakingWithdraw();
  }

  function withdrawStake()
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).withdrawStake();
  }

  function vote(uint256 _disputeId, bool _supportsDispute)
    external
    saveGas(msg.sender)
    onlyOwner {

    ITellor(tellorAddress).vote(_disputeId, _supportsDispute);
  }

}
