/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import type { FunctionFragment, Result } from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "../common";

export declare namespace Eth_Inherit {
  export type ParentStruct = {
    _address: PromiseOrValue<string>;
    name: PromiseOrValue<string>;
    surname: PromiseOrValue<string>;
    childrenAddresses: PromiseOrValue<string>[];
  };

  export type ParentStructOutput = [string, string, string, string[]] & {
    _address: string;
    name: string;
    surname: string;
    childrenAddresses: string[];
  };

  export type ChildStruct = {
    _address: PromiseOrValue<string>;
    name: PromiseOrValue<string>;
    surname: PromiseOrValue<string>;
    releaseTime: PromiseOrValue<BigNumberish>;
    balance: PromiseOrValue<BigNumberish>;
    parentAddress: PromiseOrValue<string>;
  };

  export type ChildStructOutput = [
    string,
    string,
    string,
    BigNumber,
    BigNumber,
    string
  ] & {
    _address: string;
    name: string;
    surname: string;
    releaseTime: BigNumber;
    balance: BigNumber;
    parentAddress: string;
  };
}

export interface Eth_InheritInterface extends utils.Interface {
  functions: {
    "addChild(address,string,string,uint256)": FunctionFragment;
    "addParent(address,string,string)": FunctionFragment;
    "childWithdraw()": FunctionFragment;
    "editChildInfo(address)": FunctionFragment;
    "getAllParents()": FunctionFragment;
    "getChild()": FunctionFragment;
    "getChildren(address)": FunctionFragment;
    "getChildrenAsParent()": FunctionFragment;
    "getParent()": FunctionFragment;
    "getRole(address)": FunctionFragment;
    "parentWithdraw(uint256)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "addChild"
      | "addParent"
      | "childWithdraw"
      | "editChildInfo"
      | "getAllParents"
      | "getChild"
      | "getChildren"
      | "getChildrenAsParent"
      | "getParent"
      | "getRole"
      | "parentWithdraw"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "addChild",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "addParent",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "childWithdraw",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "editChildInfo",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getAllParents",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "getChild", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "getChildren",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getChildrenAsParent",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "getParent", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "getRole",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "parentWithdraw",
    values: [PromiseOrValue<BigNumberish>]
  ): string;

  decodeFunctionResult(functionFragment: "addChild", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "addParent", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "childWithdraw",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "editChildInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getAllParents",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "getChild", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getChildren",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getChildrenAsParent",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "getParent", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "getRole", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "parentWithdraw",
    data: BytesLike
  ): Result;

  events: {};
}

export interface Eth_Inherit extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: Eth_InheritInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    addChild(
      childAddress: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      releaseTime: PromiseOrValue<BigNumberish>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    addParent(
      _address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    childWithdraw(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    editChildInfo(
      childAddress: PromiseOrValue<string>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    getAllParents(
      overrides?: CallOverrides
    ): Promise<
      [Eth_Inherit.ParentStructOutput[]] & {
        result: Eth_Inherit.ParentStructOutput[];
      }
    >;

    getChild(
      overrides?: CallOverrides
    ): Promise<
      [Eth_Inherit.ChildStructOutput] & {
        result: Eth_Inherit.ChildStructOutput;
      }
    >;

    getChildren(
      parentAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [Eth_Inherit.ChildStructOutput[]] & {
        result: Eth_Inherit.ChildStructOutput[];
      }
    >;

    getChildrenAsParent(
      overrides?: CallOverrides
    ): Promise<
      [Eth_Inherit.ChildStructOutput[]] & {
        result: Eth_Inherit.ChildStructOutput[];
      }
    >;

    getParent(
      overrides?: CallOverrides
    ): Promise<
      [Eth_Inherit.ParentStructOutput] & {
        result: Eth_Inherit.ParentStructOutput;
      }
    >;

    getRole(
      roleAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[number]>;

    parentWithdraw(
      amount: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;
  };

  addChild(
    childAddress: PromiseOrValue<string>,
    name: PromiseOrValue<string>,
    surname: PromiseOrValue<string>,
    releaseTime: PromiseOrValue<BigNumberish>,
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  addParent(
    _address: PromiseOrValue<string>,
    name: PromiseOrValue<string>,
    surname: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  childWithdraw(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  editChildInfo(
    childAddress: PromiseOrValue<string>,
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  getAllParents(
    overrides?: CallOverrides
  ): Promise<Eth_Inherit.ParentStructOutput[]>;

  getChild(overrides?: CallOverrides): Promise<Eth_Inherit.ChildStructOutput>;

  getChildren(
    parentAddress: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<Eth_Inherit.ChildStructOutput[]>;

  getChildrenAsParent(
    overrides?: CallOverrides
  ): Promise<Eth_Inherit.ChildStructOutput[]>;

  getParent(overrides?: CallOverrides): Promise<Eth_Inherit.ParentStructOutput>;

  getRole(
    roleAddress: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<number>;

  parentWithdraw(
    amount: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    addChild(
      childAddress: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      releaseTime: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    addParent(
      _address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    childWithdraw(overrides?: CallOverrides): Promise<void>;

    editChildInfo(
      childAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    getAllParents(
      overrides?: CallOverrides
    ): Promise<Eth_Inherit.ParentStructOutput[]>;

    getChild(overrides?: CallOverrides): Promise<Eth_Inherit.ChildStructOutput>;

    getChildren(
      parentAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<Eth_Inherit.ChildStructOutput[]>;

    getChildrenAsParent(
      overrides?: CallOverrides
    ): Promise<Eth_Inherit.ChildStructOutput[]>;

    getParent(
      overrides?: CallOverrides
    ): Promise<Eth_Inherit.ParentStructOutput>;

    getRole(
      roleAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<number>;

    parentWithdraw(
      amount: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {};

  estimateGas: {
    addChild(
      childAddress: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      releaseTime: PromiseOrValue<BigNumberish>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    addParent(
      _address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    childWithdraw(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    editChildInfo(
      childAddress: PromiseOrValue<string>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    getAllParents(overrides?: CallOverrides): Promise<BigNumber>;

    getChild(overrides?: CallOverrides): Promise<BigNumber>;

    getChildren(
      parentAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getChildrenAsParent(overrides?: CallOverrides): Promise<BigNumber>;

    getParent(overrides?: CallOverrides): Promise<BigNumber>;

    getRole(
      roleAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    parentWithdraw(
      amount: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    addChild(
      childAddress: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      releaseTime: PromiseOrValue<BigNumberish>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    addParent(
      _address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      surname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    childWithdraw(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    editChildInfo(
      childAddress: PromiseOrValue<string>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    getAllParents(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getChild(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getChildren(
      parentAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getChildrenAsParent(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getParent(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getRole(
      roleAddress: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    parentWithdraw(
      amount: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;
  };
}
