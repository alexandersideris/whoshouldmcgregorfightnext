import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import {Button, Glyphicon} from 'react-bootstrap'
import axios from 'axios'

export default class ShowFight extends React.Component {
  constructor(props) {
    super(props);
    this.render = this.render.bind(this);
    this.like = this.like.bind(this);
    this.unlike = this.unlike.bind(this);
  }

  like(){
    if(this.props.current_user == null){
      alert('You need to sign in to vote mate!    :)');
    }else{
      //console.log(this.props.current_user.name+ " liked fight "+this.props.fight)
      var url = "/fights/vote?id="+this.props.fight+'&user_id='+this.props.current_user.id
      //console.log(url)
      var fight = this.props.fight;
      var ctx = this.props.context
      ctx.setState({
        has_voted: fight,
        has_unvoted: '',
      });

      axios.get(url)
      .then(function (response) {
        //alert(response);
        
        if (response.status != 200){
          ctx.setState({
              has_unvoted: fight,
              has_voted: '',
            });
        }
      })
      .catch(function (error) {
        console.log(error);
      });

      
    }
  }

  unlike(){
    //console.log(this.props.current_user.name+ " unliked fight "+this.props.fight)
    var url = "/fights/unvote?id="+this.props.fight+'&user_id='+this.props.current_user.id
    //console.log(url)
    var fight = this.props.fight;
    var ctx = this.props.context
    ctx.setState({
      has_unvoted: fight,
      has_voted: '',
    });

    axios.get(url)
    .then(function (response) {
      //console.log(response);
      if (response.status != 200){
        ctx.setState({
            has_unvoted: '',
            has_voted: fight,
          });
      }
    })
    .catch(function (error) {
      console.log(error);
    });
  }

  render() {

    var upvotes = this.props.upvotes;
    var has_voted = this.props.has_voted;
    var fight = this.props.fight
    var fighter_one = this.props.fighter_one
    var fighter_two = this.props.fighter_two
    var upvotes = this.props.upvotes
    var str = ''


    if(this.props.division == 'Superfight'){
      str = "Superfight"
    }

    if(this.props.isMobile == 'true'){
      if(this.props.has_voted == 'true'){

        // User is using mobile device and has voted for the fight
        return (
          <div style={{ border: 'black', backgroundColor: ''}}>

            <div style={{display: 'flex', flexWrap: 'nowrap', backgroundColor: ''}}>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px'}}>
                <img responsive='true' src={fighter_one.img_url} style={{backgroundColor: 'gray'}} />
                <p style={{fontSize: 35, marginTop: 15}}>{fighter_one.name}</p>
                <p style={{fontSize: 28, margin: 10}}>{fighter_one.rank}</p>
                <p style={{fontSize: 22}}>{fighter_one.fight_record}</p>
              </div>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px'}}>
                <img responsive='true' src={fighter_two.img_url} style={{backgroundColor: 'gray'}}/>
                <p style={{fontSize: 35, marginTop: 15}}>{fighter_two.name}</p>
                <p style={{fontSize: 28, margin: 10}}>{fighter_two.rank}</p>
                <p style={{fontSize: 22}}>{fighter_two.fight_record}</p>
              </div>
            </div>

            <div style={{minWidth: '1140px', textAlign: 'center', backgroundColor: '', marginBottom: '150px'}}>
              <p style={{fontSize: 30, marginBottom: 10, color: 'red'}}>{str}</p>
              <p style={{fontSize: 30, marginBottom: 10}}>Upvotes: {upvotes}</p>
              <Button onClick={()=>this.unlike()} bsStyle="success"  style={{fontSize: 30}} active>You upvoted this fight</Button>
            </div>

          </div>
        );

      }else{

        // User is using on mobile device and has not voted for the fight
        return (
          <div style={{ border: 'black', backgroundColor: ''}}>

            <div style={{display: 'flex', flexWrap: 'nowrap', backgroundColor: ''}}>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px', backgroundColor: ''}}>
                <img responsive='true' src={fighter_one.img_url} style={{backgroundColor: 'gray'}} />
                <p style={{fontSize: 36, marginTop: 15}}>{fighter_one.name}</p>
                <p style={{fontSize: 28, margin: 10}}>{fighter_one.rank}</p>
                <p style={{fontSize: 22, margin: 10}}>{fighter_one.fight_record}</p>
              </div>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px', backgroundColor: ''}}>
                <img responsive='true' src={fighter_two.img_url} style={{backgroundColor: 'gray'}}/>
                <p style={{fontSize: 35, marginTop: 15}}>{fighter_two.name}</p>
                <p style={{fontSize: 28, margin: 10}}>{fighter_two.rank}</p>
                <p style={{fontSize: 22, margin: 10}}>{fighter_two.fight_record}</p>
              </div>
            </div>

            <div style={{minWidth: '1140px', textAlign: 'center', backgroundColor: '', marginBottom: '150px'}}>
              <p style={{fontSize: 30, marginBottom: 10, color: 'red'}}>{str}</p>
              <p style={{fontSize: 30, marginBottom: 10}}>Upvotes: {upvotes}</p>
              <Button ref="button" onClick={()=>this.like()} bsStyle="info" style={{fontSize: 30}}>Upvote this fight!</Button>
            </div>

          </div>
        );
      }
    }else{
      if(this.props.has_voted == 'true'){

        // User is using Desktop device and has voted for the fight
        return (
          <div style={{ border: 'black', backgroundColor: ''}}>

            <div style={{display: 'flex', flexWrap: 'nowrap', backgroundColor: ''}}>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px'}}>
                <img responsive='true' src={fighter_one.img_url} style={{backgroundColor: 'gray'}} />
                <p style={{fontSize: 25, margin: 10}}>{fighter_one.name}</p>
                <p style={{fontSize: 20, margin: 10}}>{fighter_one.rank}</p>
                <p style={{fontSize: 17}}>{fighter_one.fight_record}</p>
              </div>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px'}}>
                <img responsive='true' src={fighter_two.img_url} style={{backgroundColor: 'gray'}}/>
                <p style={{fontSize: 25, margin: 10}}>{fighter_two.name}</p>
                <p style={{fontSize: 20, margin: 10}}>{fighter_two.rank}</p>
                <p style={{fontSize: 17}}>{fighter_two.fight_record}</p>
              </div>
            </div>

            <div style={{minWidth: '1140px', textAlign: 'center', backgroundColor: '', marginBottom: '150px'}}>
              <p style={{fontSize: 30, marginBottom: 10, color: 'red'}}>{str}</p>
              <p style={{fontSize: 30, marginBottom: 10}}>Upvotes: {upvotes}</p>
              <Button onClick={()=>this.unlike()} bsStyle="success"  style={{fontSize: 22}} active>You upvoted this fight</Button>
            </div>

          </div>
        );

      }else{

        // User is using Desktop device and has not voted for the fight
        return (
          <div style={{ border: 'black', backgroundColor: ''}}>

            <div style={{display: 'flex', flexWrap: 'nowrap', backgroundColor: ''}}>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px', backgroundColor: ''}}>
                <img responsive='true' src={fighter_one.img_url} style={{backgroundColor: 'gray'}} />
                <p style={{fontSize: 25, margin: 10}}>{fighter_one.name}</p>
                <p style={{fontSize: 20, margin: 10}}>{fighter_one.rank}</p>
                <p style={{fontSize: 17, margin: 10}}>{fighter_one.fight_record}</p>
              </div>

              <div className="col-lg-6" style={{textAlign: 'center', margin: '10px', backgroundColor: ''}}>
                <img responsive='true' src={fighter_two.img_url} style={{backgroundColor: 'gray'}}/>
                <p style={{fontSize: 25, margin: 10}}>{fighter_two.name}</p>
                <p style={{fontSize: 20, margin: 10}}>{fighter_two.rank}</p>
                <p style={{fontSize: 17, margin: 10}}>{fighter_two.fight_record}</p>
              </div>
            </div>

            <div style={{minWidth: '1140px', textAlign: 'center', backgroundColor: '', marginBottom: '150px'}}>
              <p style={{fontSize: 30, marginBottom: 10, color: 'red'}}>{str}</p>
              <p style={{fontSize: 25, marginBottom: 10}}>Upvotes: {upvotes}</p>
              <Button ref="button" onClick={()=>this.like()} bsStyle="info" style={{fontSize: 22}}>Upvote this fight!</Button>
            </div>

          </div>
        );
      }
    }
  }
      
}
