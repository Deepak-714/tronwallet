function tron(url, key) {
    return new TronWeb({
        fullHost: url,
        privateKey: key
    });
} function tronnew(url) {
    return new TronWeb({
        fullHost: url,
    });
}

async function createAccount(url) {
    const vr = tronnew(url);
    let bal = await vr.createAccount();
    console.log(JSON.stringify(bal));
    return JSON.stringify(bal);
}
async function getbalance(address, url) {
    const vr = tronnew(url);
    let bal = await vr.trx.getBalance(address);
    console.log(bal);
    return JSON.stringify(bal);
}
async function Sendtrx(pvtkey, to, amount, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.sendTrx(to, amount);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return broad;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function Signtranstion(transtion, key, url) {
    try {
        const vr = await tron(url, key);
        let sign = await vr.trx.sign(transtion, key.toString());
        console.log(JSON.stringify(sign));
        return sign;
    } catch (e) {
        console.error(e)
        return e;
    }

}

// async function sendTrc20Token(triggerdata, pvtkey) {
//     let sign = await Signtranstion(triggerdata, pvtkey);
//     const datasign = JSON.stringify(sign);
//     console.info(datasign);
//     return datasign;
// }
async function broadcast(signdata, url, userkey) {
    const vr = await tron(url, userkey);
    let broadcastdata = await vr.trx.sendRawTransaction(JSON.parse(signdata));
    return broadcastdata;
}
async function getTransactionInfo(hash, url) {
    const vr = await tronnew(url);
    let broadcastdata = await vr.trx.getTransactionInfo(hash);
    console.log(JSON.stringify(broadcastdata))
    return broadcastdata;
}
async function getAccount(address, url) {
    const vr = await tronnew(url);
    let info = await vr.trx.getAccount(address);
    console.log(JSON.stringify(info))
    return info;
}
async function SignBroad(transtion, key, url) {
    let userkey = key;
    try {
        const vr = await tron(url, userkey);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return broad;
    } catch (e) {
        console.log(e);
        return;
    }
}


// async function SendTRC20(contractaddress, walletaddres, pvt, ReceiverAddress, amountInContactType, url) {

//     let userkey = pvt;
//     const vr = await tron(url, userkey);
//     const options = {
//         feeLimit: 10000000,
//         callValue: 0,
//     }
//     try {
//         var parameter = [
//             { type: 'address', value: ReceiverAddress },
//             { type: 'uint256', value: amountInContactType }
//         ];
//         await vr.transactionBuilder.triggerSmartContract(contractaddress, "transfer(address,uint256)", options, parameter, walletaddres).then(async (value) => {
//             let sign = await vr.trx.sign(value, userkey.toString());
//             let broad = await vr.trx.sendRawTransaction(sign);
//             console.log(JSON.stringify(broad));
//             return;

//         });
//     } catch (e) {
//         console.error(e);
//         return;
//     }
// }
async function freezeBalanceV2(pvtkey, address, amount, resource, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.freezeBalanceV2(amount, resource, address);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function unfreezeBalanceV2(pvtkey, address, amount, resource, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.unfreezeBalanceV2(amount, resource, address);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function applyForSR(pvtkey, address, srurl, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.applyForSR(address, srurl);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function vote(pvtkey, address, votes, url) {
    // console.log(votes);
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.vote(votes, address, 1);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function voteProposal(pvtkey, address, proposalId, hasApproval, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.voteProposal(proposalId, hasApproval, address);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}
async function deleteProposal(pvtkey, address, proposalId, url) {
    try {
        let userkey = pvtkey;
        const vr = await tron(url, userkey);
        let transtion = await vr.transactionBuilder.deleteProposal(proposalId, address);
        let sign = await vr.trx.sign(transtion, userkey.toString());
        let broad = await vr.trx.sendRawTransaction(sign);
        console.log(JSON.stringify(broad));
        return transtion;
    } catch (e) {
        console.error(e)
        return e;
    }
}