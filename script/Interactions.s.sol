//SPDX-License_Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1e18;

    function fundFundMe(address mostRecentDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("mostRecentDeployed %s", mostRecentDeployed);
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeployedContract = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        fundFundMe(mostRecentDeployedContract);
    }
}

contract WithdrawFundMe is Script {
    uint256 constant SEND_VALUE = 0.1e18;

    function withdrawFundMe(address mostRecentDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("mostRecentDeployed %s", mostRecentDeployed);
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeployedContract = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        withdrawFundMe(mostRecentDeployedContract);
    }
}
