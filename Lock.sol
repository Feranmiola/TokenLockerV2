/**
 *Submitted for verification at testnet.bscscan.com on 2023-06-14
*/

// File: @openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol


// OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
     * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
     *
     * _Available since v4.8._
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason or using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}

// File: @openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol


// OpenZeppelin Contracts (last updated v4.8.1) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.2;


/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts.
     *
     * Similar to `reinitializer(1)`, except that functions marked with `initializer` can be nested in the context of a
     * constructor.
     *
     * Emits an {Initialized} event.
     */
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) || (!AddressUpgradeable.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * A reinitializer may be used after the original initialization step. This is essential to configure modules that
     * are added through upgrades and that require initialization.
     *
     * When `version` is 1, this modifier is similar to `initializer`, except that functions marked with `reinitializer`
     * cannot be nested. If one is invoked in the context of another, execution will revert.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     *
     * WARNING: setting the version to 255 will prevent any future reinitialization.
     *
     * Emits an {Initialized} event.
     */
    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: contract is already initialized");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version);
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     *
     * Emits an {Initialized} event the first time it is successfully executed.
     */
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }

    /**
     * @dev Returns the highest version that has been initialized. See {reinitializer}.
     */
    function _getInitializedVersion() internal view returns (uint8) {
        return _initialized;
    }

    /**
     * @dev Returns `true` if the contract is currently initializing. See {onlyInitializing}.
     */
    function _isInitializing() internal view returns (bool) {
        return _initializing;
    }
}

// File: @openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-IERC20PermitUpgradeable.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/draft-IERC20Permit.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
interface IERC20PermitUpgradeable {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// File: @openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20Upgradeable {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}



// File: @openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol


// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20Upgradeable {
    using AddressUpgradeable for address;

    function safeTransfer(
        IERC20Upgradeable token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20Upgradeable token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    function safePermit(
        IERC20PermitUpgradeable token,
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal {
        uint256 nonceBefore = token.nonces(owner);
        token.permit(owner, spender, value, deadline, v, r, s);
        uint256 nonceAfter = token.nonces(owner);
        require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20Upgradeable token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: lplock.sol


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/**
 * @title TokenTimeLock
 * @author PurpleSale
 * @notice A contract for locking and releasing tokens based on vesting schedules.
 */


contract TokenTimeLock{
     /**
     * @notice SafeERC20Upgradeable is used for all token transfers
     */
    using SafeERC20Upgradeable for IERC20Upgradeable;

    
    uint256 public id;

     /**
     * @notice Mapping of locked tokens for each user.
     */

    mapping(address => mapping(uint => mapping (uint => Locks))) public LockedTokens;
    
     /**
     * @notice Mapping of the number of vesting cycles for each lock ID
     */
    mapping(address => mapping (uint => uint)) public cycleCountPerID;
     
     /**
     * @notice Mapping of the total token amount locked for an ID
     */
    mapping(uint => mapping (address => uint)) public totalTokenAmount;

      /**
     * @notice Mapping of the number of claimed vesting cycles for each lock ID
     */
    mapping(address => mapping (uint => uint)) private claimCycleCountPerID;

    mapping(uint => uint[]) private usedPercentages;


      /**
     * @dev Emitted when a new lock is created.
     * @param user The address of the user who created the lock.
     * @param token The address of the token that was locked.
     * @param ID The ID of the lock.
     */

    event Locked(address indexed user, address indexed token, uint ID);

      /**
     * @notice Struct representing a lock.
     * @param ID The ID of the lock.
     * @param owner The owner or creator of the lock
     * @param Token The token address of the locked token
     * @param Beneficiary The wallet or contract address recieving the tokens when released
     * @param amount The total amount of tokens being locked
     * @param releaseTime The date in timestamp where the token will be abke to be released
     * @param liquidity A boolean value used to differentiate liquidity tokens fron normal tokens
     * @param claimed A boolean value used to check if a token has been released from the contract
     
     ///Inputs
     * @param Vesting A boolean value used to specify if the token is a vested token or not
     * @param FirstPercent The percentage of the total token amount to be released first
     * @param firstReleaseTime The date in timestamp when the first percentage of the total tokens should be able to be released
     * @param cyclePercent The percentage to be released eacg vesting cycle
     * @param cycleReleaseTime The total time gap in seconds  between each cycle
     * @param cycleCount The total number of times a locked token will be released or the total number of cycles there are, including the first release
     */
    
    struct Locks {
        address owner;
        address Token;
        address Beneficiary;
        uint256 amount;
        uint256 releaseTime;
        bool liquidity;
        bool Claimed;
    }

    struct inputs{
        address Token;
        address Beneficiary;
        uint256 amount;
        bool liquidity;
        uint256 FirstPercent;
        uint256 firstReleaseTime;
        uint256 cyclePercent;
        uint256 cyclereleaseTime;
        uint256 cycleCount;
    }

    
    /**
     * @notice Called from the PurpleSale Presale contract to lock a liquidity token once the sale ends
     * @notice Function does not support tokens with fees or rebase tokens
     * @dev This function transfers tokens from the PurpleSale presale cpntract  to this contract, creates a new lock, and emits a Locked event.
     * @param owner The address of the user who will own the lock.
     * @param token_ The address of the token to be locked.
     * @param beneficiary_ The address of the beneficiary of the lock.
     * @param releaseTime_ The timestamp when the lock will be released.
     * @param amount_ The amount of tokens to be locked.
     * @param _liquidity A flag indicating if the token is a liquidity token or not.
     */
    
    function launchLock(address owner,  address token_, address beneficiary_, uint256 releaseTime_, uint256 amount_, bool _liquidity) external {
    
        id++;
        
        IERC20Upgradeable(token_).safeTransferFrom(msg.sender, address(this), amount_);

        LockedTokens[owner][id][1] = Locks ({
            owner : owner,
            Token : token_,
            Beneficiary : beneficiary_,
            amount : amount_,
            releaseTime: releaseTime_,
            liquidity : _liquidity,
            Claimed : false

        });

        
        cycleCountPerID[owner][id] = 1;


        emit Locked(owner, token_, id);  
    
    }


    /**
        * @notice Creates a new token lock.
        * @notice Function does not support tokens with fees or rebase tokens
        * @dev This function transfers tokens from the sender to this contract, creates a new lock, and emits a Locked event.
        * @param Inputs A struct containing the following fields:
        * - `Token`: The address of the token to be locked.
        * - `Beneficiary`: The address of the beneficiary of the lock.
        * - `amount`: The amount of tokens to be locked.
        * - `liquidity`: A boolean indicating whether the lock is a liquidity token.
        * - `Vesting`: A boolean indicating whether the lock has vested cycles.
        * - `FirstPercent`: The percentage of tokens to be released first.
        * - `firstReleaseTime`: The unix timestamp when the first release can be made.
        * - `cyclePercent`: The percentage of tokens to be released in each cycle.
        * - `cyclereleaseTime`: The time interval between each release cycle.
        * - `cycleCount`: The number of release cycles.
    */


     function Lock(inputs calldata Inputs) external{
        uint count = Inputs.cycleCount; 

        require(count > 0, "Count is O");
        require(Inputs.amount > 0, "Lock amount is 0");

        bool Vesting = count > 1;
        

        uint totalPrecent;

        require(Inputs.FirstPercent <= 10000, "firstPercentage greater then 100%");
        
        uint percentAmount;
        uint firstAmount;

        if(Vesting){
            totalPrecent = Inputs.FirstPercent + ((count - 1) * Inputs.cyclePercent);
            percentAmount = Inputs.amount  * Inputs.cyclePercent /10000;

            firstAmount = Inputs.amount * Inputs.FirstPercent /10000;
        }else{
            totalPrecent = Inputs.FirstPercent;
            firstAmount = Inputs.amount;
        }

        require(totalPrecent >= 10000, "Percent Not Up To 100"); 

        IERC20Upgradeable(Inputs.Token).safeTransferFrom(msg.sender, address(this), Inputs.amount);        

        id++;

        totalTokenAmount[id][Inputs.Token] = Inputs.amount;


        LockedTokens[msg.sender][id][1] = Locks ({
            owner : msg.sender,
            Token :Inputs.Token,
            Beneficiary : Inputs.Beneficiary,
            amount : firstAmount,
            releaseTime: Inputs.firstReleaseTime,
            liquidity : Inputs.liquidity,
            Claimed : false

        });


        uint lastTime = Inputs.firstReleaseTime;
        uint maxPrecent = Inputs.FirstPercent;

        if(Vesting){

            usedPercentages[id].push(Inputs.FirstPercent);
            usedPercentages[id].push(Inputs.cyclePercent);

            for(uint i = 2; i <= count; i++){
                
                maxPrecent += Inputs.cyclePercent;

                if(maxPrecent > 10000){
                    maxPrecent -= Inputs.cyclePercent;
                    uint percent = 10000 - maxPrecent;

                    percentAmount = Inputs.amount  * percent /10000;

                    maxPrecent = 10000;

                }

                lastTime += Inputs.cyclereleaseTime;

                    LockedTokens[msg.sender][id][i] = Locks ({
                        owner : msg.sender,
                        Token :Inputs.Token,
                        Beneficiary : Inputs.Beneficiary,
                        amount : percentAmount,
                        releaseTime: lastTime,
                        liquidity : Inputs.liquidity,
                        Claimed : false

                    });

                }

                
        }


        cycleCountPerID[msg.sender][id] = count;
        

        emit Locked(msg.sender, Inputs.Token, id);  


    }


    /**
    * @notice Returns the lock details for a given owner, ID, and index.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The lock details.
    */

    function getTransaction(address owner_, uint index, uint256 vIndex) external view returns(Locks memory){
        return LockedTokens[owner_][index][vIndex];
    }

    /**
    * @notice Returns the token address for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The token address.
    */

    function token(address owner_, uint index, uint vIndex) external view returns (address) {
        return LockedTokens[owner_][index][vIndex].Token;
    }

    /**
    * @notice Returns the beneficiary address for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The beneficiary address.
    */

    function beneficiary(address owner_, uint index, uint vIndex) external view returns (address) {
        return LockedTokens[owner_][index][vIndex].Beneficiary;
    }

    /**
    * @notice Returns the release time for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The release time.
    */

    function releaseTime(address owner_, uint index, uint vIndex) external view returns (uint256) {
        return LockedTokens[owner_][index][vIndex].releaseTime;
    }

    /**
    * @notice Returns the amount of tokens for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param Id The ID of the lock.
    * @param index The index of the lock.
    * @return The amount of tokens.
    */
    
    function amount(address owner_, uint Id, uint index) external view returns(uint256){
        return LockedTokens[owner_][Id][index].amount;
    }

    /**
    * @notice Returns the claimed status for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The claimed status.
    */

    function getClaimed(address owner_, uint index, uint vIndex) external view returns(bool){
        return LockedTokens[owner_][index][vIndex].Claimed;
    }
    
    /**
    * @notice Returns the liquidity status for a given lock.
    * @param owner_ The address of the owner of the lock.
    * @param index The ID of the lock.
    * @param vIndex The index of the lock.
    * @return The liquidity status.
    */
    
    function isLiquidity(address owner_, uint index, uint vIndex) external view returns(bool){
        return LockedTokens[owner_][index][vIndex].liquidity;
    }

    
    /**
    * @notice Retrieves the number of locks for a given owner and index.
    * @dev This function returns the count of locks associated with the provided owner and index.
    * @param owner The address of the owner of the lock.
    * @param index The index of the lock.
    * @return The number of locks for the given owner and index.
    */

    function getLockCount(address owner, uint index) external view returns(uint){
        return cycleCountPerID[owner][index];
    }



    /**
    * @notice Changes the beneficiary of a lock.
    * @dev This function changes the beneficiary of all cycles of a lock.
    * @param index The index of the lock.
    * @param newBeneficiary The new beneficiary address.
    */

    // function changeBeneficiary(uint index, address newBeneficiary) external{
    //     require(msg.sender == LockedTokens[msg.sender][index][1].owner, "Not owner");
    //     require(!LockedTokens[msg.sender][index][cycleCountPerID[msg.sender][index]].Claimed, "token Claiming Started");

    //     uint counter = 1;
    //     uint count = cycleCountPerID[msg.sender][index];
    //     uint _claimCount = claimCycleCountPerID[msg.sender][index];
        
    //     if(_claimCount > 1 && count > _claimCount){
    //         counter = _claimCount +1;
    //     }

    //     for(uint i = counter; i <= count; i++){
    //         LockedTokens[msg.sender][index][i].Beneficiary = newBeneficiary;
    //     }

    // }

    
    /**
    * @notice Changes the release time and token distribution percentages for each cycle of a vesting lock.
    * @dev This function changes the first release time, the time gap between each release cycle, and the amount of tokens for each cycle of a vesting lock based on the new time, time gap, and percentages provided. It does this by iterating over each cycle of the lock and setting the new release time and amount of tokens for that cycle based on the new time gap and percentages provided.
    * @param index The index of the lock.
    * @param newTime The new first release time.
    * @param newCycleGap The new time gap between each release cycle.
    * @param newPercentages An array of new percentages for each cycle of the lock. The percentages are expressed as parts per 10,000 (i.e., a value of 10000 represents 100%).
    */
    
    function changeReleaseTimeAndSpread(uint index, uint newTime, uint newCycleGap, uint[] memory newPercentages, uint additionalAmount) external{
        //Make sure the owner is the caller
        require(msg.sender == LockedTokens[msg.sender][index][1].owner, "Not owner");
        //Make sure the newtime is greater than the previous set release time
        require(newTime >= LockedTokens[msg.sender][index][1].releaseTime, "Time cant be Older");
        //Make sure claiming has not started 
        require(!LockedTokens[msg.sender][index][1].Claimed, "token Claiming Started");

        uint count = cycleCountPerID[msg.sender][index];
        

    

        if(additionalAmount > 0){
            IERC20Upgradeable(LockedTokens[msg.sender][index][1].Token).safeTransferFrom(msg.sender, address(this), additionalAmount);
            totalTokenAmount[index][LockedTokens[msg.sender][index][1].Token]+= additionalAmount;
        }

        
        
        if(count > 1 && newPercentages[1] > 0 && newPercentages[0] > 0){

            uint percentageAmount;
            uint maxPercent;
            uint percent;
            uint counter;
            uint gapTime;

            gapTime = LockedTokens[msg.sender][index][2].releaseTime - LockedTokens[msg.sender][index][1].releaseTime;            
            
            if(newCycleGap < gapTime || newPercentages[0] >= 10000){
                revert("Ngap < Ogap | %error");
            }else{

                if((newPercentages[0] > usedPercentages[index][0]) || (newPercentages[1] > usedPercentages[index] [1])  ){
                    revert("Invalid Percentage");
                }

                percent = newPercentages[0];
            
                maxPercent += newPercentages[0];
                
                counter++;
    
                percentageAmount = percent * totalTokenAmount[index][LockedTokens[msg.sender][index][1].Token]/10000;
                
                LockedTokens[msg.sender][index][counter].amount = percentageAmount;
                
                //While loop runs to make sure the percentage cummulation is 100% or less

                while(maxPercent < 10000){
                    percent = newPercentages[1];
                    maxPercent += newPercentages[1];

                    //checks if percent cummulation is over 100% then recalculates it to an amount just enough for 100%
                    if(maxPercent > 10000){
                        maxPercent -= newPercentages[1];
                        percent = 10000 - maxPercent;
                        maxPercent = 10000;
                    }
                            
                    percentageAmount = percent * totalTokenAmount[index][LockedTokens[msg.sender][index][1].Token]/10000;
                    counter++;

                    //Checks if the current counter is over the perviously set counter, then sets values for the indexes that didnt have values previously
                    if(count < counter){
                        LockedTokens[msg.sender][index][counter] = Locks ({
                            owner : msg.sender,
                            Token :LockedTokens[msg.sender][index][1].Token,
                            Beneficiary : LockedTokens[msg.sender][index][1].Beneficiary,
                            amount : percentageAmount,
                            releaseTime: LockedTokens[msg.sender][index][count].releaseTime,
                            liquidity : LockedTokens[msg.sender][index][1].liquidity,
                            Claimed : false
                            });
                    }else{
                        LockedTokens[msg.sender][index][counter].amount = percentageAmount;
                    }
                }

                
                //Update the counter
                cycleCountPerID[msg.sender][index] = counter;

                count = counter;
                

            }

        }

        //Checks if the current counter is less than the old count, since the percentage has been redistributed, the other indexes are deleted
        //SInce the percentage cannot be increased, the counter cannot be lower than the original count it can only be higher
        // if(counter < count){
        //     for(uint i = counter + 1; i <= count; i++){
        //         delete LockedTokens[msg.sender][index][i];
        //     }
        // }

        //Update the time
        LockedTokens[msg.sender][index][1].releaseTime = newTime;      
        //checks if token is vested, the applys new cycle gap time
        if(count > 1){
            for(uint i = 2; i<= count; i++){
                newTime += newCycleGap;

                LockedTokens[msg.sender][index][i].releaseTime = newTime;
            }
        }

    }


     
    /**
    * @notice Releases tokens based on the vesting schedule.
    * @dev This function checks the vesting schedule and calls the appropriate claim function.
    * @param index The index of the lock.
    */

     function Release(uint index) external  {

        if(cycleCountPerID[msg.sender][index] == 1){
            _normalClaim(index);

        }else{
            _vestingClaim(index);
        }

    }

    /**
    * @notice Claims tokens for a normal lock.
    * @dev This function checks the claim status and release time, then transfers the tokens to the beneficiary.
    * @param index The index of the lock.
    */
    
    function _normalClaim(uint index) internal{
        uint claimCount = 1;

          require(!LockedTokens[msg.sender][index][claimCount].Claimed, "Claimed");
          require(block.timestamp > LockedTokens[msg.sender][index][claimCount].releaseTime, "Release Time Not Reached");

            address _token = LockedTokens[msg.sender][index][claimCount].Token;
            address _beneficiary = LockedTokens[msg.sender][index][claimCount].Beneficiary;


            uint amount__ = LockedTokens[msg.sender][index][claimCount].amount;


            LockedTokens[msg.sender][index][claimCount].Claimed =  true;


            IERC20Upgradeable(_token).safeTransfer(_beneficiary, amount__);
    }

    /**
    * @notice Claims tokens for a vesting lock.
    * @dev This function checks the claim status and release time for each vesting cycle, then transfers the claimable tokens to the beneficiary.
    * @dev This function seems to fail when called if declared as internal, still unsure why
    * @param index The index of the lock.
    */

    function _vestingClaim(uint index) public{ 
        uint count = cycleCountPerID[msg.sender][index];
        require(claimCycleCountPerID[msg.sender][index] < count, "Claim Complete");

        uint claimCount = claimCycleCountPerID[msg.sender][index] + 1;

        require(block.timestamp >= LockedTokens[msg.sender][index][claimCount].releaseTime, "Time Not reached");

        require(!LockedTokens[msg.sender][index][claimCount].Claimed, "Claimed");

        address _token = LockedTokens[msg.sender][index][1].Token;
        address _beneficiary = LockedTokens[msg.sender][index][1].Beneficiary;

        uint claimmableAmount;

        for(uint i = claimCount; i <= count; i++){

            if(block.timestamp >= LockedTokens[msg.sender][index][i].releaseTime){
                
                LockedTokens[msg.sender][index][i].Claimed = true;

                claimmableAmount += LockedTokens[msg.sender][index][i].amount;

                claimCycleCountPerID[msg.sender][index] ++;

            } else{
                break;
            }
        }
            
        IERC20Upgradeable(_token).safeTransfer(_beneficiary, claimmableAmount);

    }

}