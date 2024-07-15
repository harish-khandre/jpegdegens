import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";
import { expect } from "chai";

describe("Hero", function () {
  async function createHero() {
    const Hero = await ethers.getContractFactory("Heros");
    const hero = await Hero.deploy();
    await hero.deployed();
    return hero;
  }

  let hero;

  before(async function () {
    hero = await createHero();
  });

  it("should get a hero array", async function () {
    expect(await hero.getHeroes()).to.deep.equal([]);
  });

  it("should cause payment error", async function () {
    let e;
    try {
      await hero.createHero(0, {
        value: ethers.utils.parseEther("0.04999999"),
      });
    } catch (error) {
      e = error;
    }

    expect(e.message.includes("Not enough ether sent")).to.equal(true);
  });
});
