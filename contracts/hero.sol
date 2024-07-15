// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Heros {
    enum Class {
        Mage,
        Healer,
        Barbarian
    }

    mapping(address => uint[]) addressToHeroes;

    function generateRandom() public view returns (uint) {
        return
            uint(
                keccak256(abi.encodePacked(block.prevrandao, block.timestamp))
            );
    }

    function getHeroes() public view returns (uint[] memory) {
        return addressToHeroes[msg.sender];
    }

    function createHero(Class class) public payable {
        require(msg.value >= 0.05 ether, "Not enough ether sent");

        uint[] memory stats = new uint[](5);
        stats[0] = 2;
        stats[1] = 7;
        stats[2] = 12;
        stats[3] = 17;
        stats[4] = 22;

        uint len = 5;
        uint hero = uint(class);

        do {
            uint pos = generateRandom() % len;
            uint value = (generateRandom() % (13 + len)) + 1;

            hero |= value << stats[pos];

            len--;
            stats[pos] = stats[len];
        } while (len > 0);

        addressToHeroes[msg.sender].push(hero);
    }
}
