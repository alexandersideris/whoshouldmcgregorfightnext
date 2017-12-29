import React from 'react';
import {Nav, Navbar, NavItem, NavDropdown, MenuItem, Glyphicon, DropdownButton} from 'react-bootstrap'
import axios from 'axios'

export default class NavigationBar extends React.Component {
  constructor(props) {
    super(props);
    this.render = this.render.bind(this);
    this.changeDivision = this.changeDivision.bind(this);
    this.changeFighter = this.changeFighter.bind(this);
    this.superfight = this.superfight.bind(this);
    this.updateFights = this.updateFights.bind(this);
  }

  changeDivision(division){
    /*this.props.context.setState({
      division: division,
      the_fighter: '',
      superfights: 'false'
    });*/

    this.updateFights(division, '', 'false')
  }

  changeFighter(the_fighter){
    /*this.props.context.setState({
      division: "None",
      the_fighter: the_fighter,
      superfights: 'false'
    });*/
    this.updateFights("None", the_fighter, 'false')
  }

  superfight(){
    /*this.props.context.setState({
      division: "None",
      the_fighter: '',
      superfights: 'true'
    });*/
    this.updateFights("None", '', 'true')
  }

  updateFights(division, the_fighter, superfights){
    
    var context = this.props.context
    var url = '/fights/get_fights?division='+division+'&superfights='+superfights+'&the_fighter='+the_fighter
    var self = this

    axios.get(url)
    .then(function (response) {
      if (response.status == 200){
        context.setState({
              fights: response.data,
              division: division,
              the_fighter: the_fighter,
              superfights: superfights,
            });
      }
    })
    .catch(function (error) {
      console.log(error);
    });

  }

  render() {
    
    const fontsMobile = {
        fontSize: 40,
        paddingTop: 30,
        paddingBottom: 30,
    };

    var fighters = this.props.fighters;
    var self = this;
    if(this.props.isMobile=='true'){
      if(this.props.current_user == null){

        // User is using mobile and is not logged in
        return (
          <div>
            <Navbar inverse collapseOnSelect fixedTop className="bs-navbar-collapse">
              <Navbar.Header>
                <Navbar.Brand>
                  {/*<a href="#"><img src="https://i.imgur.com/Xs3GP6z.png" style={{width: '65px', marginBottom: '5px'}} /></a>*/}
                  <a style={{color: 'white', fontSize: 40, marginTop: 20}} href="#" onClick={()=>self.changeDivision('Popular')}><Glyphicon glyph="fire" /> Who Should McGregor Fight Next? </a>
                </Navbar.Brand>
                <Navbar.Toggle style={{height: 100, paddingLeft:100, paddingRight:100, backgroundColor: '', borderStyle: 'solid', borderColor: 'white'}}/>
              </Navbar.Header>
              <Navbar.Collapse style={{maxHeight: '800px'}}>
                <Nav>
                  <NavDropdown eventKey={3} title="Divisions" id="basic-nav-dropdown" style={fontsMobile}>
                    <MenuItem style={fontsMobile} eventKey={3.3} onClick={()=>self.changeDivision('Featherweight')}>Featherweight</MenuItem>
                    <MenuItem style={fontsMobile} eventKey={3.4} onClick={()=>self.changeDivision('Lightweight')}>Lightweight</MenuItem>
                    <MenuItem style={fontsMobile} eventKey={3.5} onClick={()=>self.changeDivision('Welterweight')}>Welterweight</MenuItem>
                  </NavDropdown>
                </Nav>
                <Nav>
                  <MenuItem style={{fontSize: 40, paddingTop: 10, paddingBottom: 10}} eventKey={2} href="https://www.mmamatchups.net">View All Fighters</MenuItem>
                </Nav>
                <Nav pullRight>
                  <MenuItem style={{fontSize: 30, paddingBottom: 10}} eventKey={1} href="/auth/google_oauth2">   <Glyphicon glyph="log-in" />   Sign In With Google</MenuItem>
                </Nav>
              </Navbar.Collapse>
            </Navbar>
          </div>
        );
      }else{

        // User is using mobile and is logged in
        return (
          <div>
            <Navbar inverse collapseOnSelect fixedTop>
              <Navbar.Header>
                <Navbar.Brand>
                  {/*<a href="#"><img src="https://i.imgur.com/Xs3GP6z.png" style={{width: '65px', marginBottom: '5px'}} /></a>*/}
                  <a style={{color: 'white', fontSize: 40, marginTop: 20}} href="#" onClick={()=>self.changeDivision('Popular')}><Glyphicon glyph="fire" /> Who Should McGregor Fight Next? </a>
                </Navbar.Brand>
                <Navbar.Toggle style={{height: 100, paddingLeft:100, paddingRight:100, backgroundColor: '', borderStyle: 'solid', borderColor: 'white'}}/>
              </Navbar.Header>
              <Navbar.Collapse style={{maxHeight: '800px'}}>
                <Nav>
                  <NavDropdown eventKey={3} title="Divisions" id="basic-nav-dropdown" style={fontsMobile}>
                    <MenuItem style={fontsMobile} eventKey={3.3} onClick={()=>self.changeDivision('Featherweight')}>Featherweight</MenuItem>
                    <MenuItem style={fontsMobile} eventKey={3.4} onClick={()=>self.changeDivision('Lightweight')}>Lightweight</MenuItem>
                    <MenuItem style={fontsMobile} eventKey={3.5} onClick={()=>self.changeDivision('Welterweight')}>Welterweight</MenuItem>
                  </NavDropdown>
                </Nav>
                <Nav>
                  <MenuItem style={{fontSize: 40, paddingTop: 10, paddingBottom: 10}} eventKey={2} href="https://www.mmamatchups.net">View All Fighters</MenuItem>
                </Nav>
                <Nav pullRight>
                  <MenuItem style={{fontSize: 30, paddingBottom: 10}} eventKey={2} href="signout"><Glyphicon glyph="log-out" />   Log Out</MenuItem>
                </Nav>
              </Navbar.Collapse>
            </Navbar>
          </div>
        );
      }
    }else{
      if(this.props.current_user == null){

        // User is using Desktop and is not logged in
        return (
          <div>
            <Navbar inverse collapseOnSelect fixedTop className="bs-navbar-collapse">
              <Navbar.Header>
                <Navbar.Brand>
                  {/*<a href="#"><img src="https://i.imgur.com/Xs3GP6z.png" style={{width: '65px', marginBottom: '5px'}} /></a>*/}
                  <a style={{color: 'white'}} href="#" onClick={()=>self.changeDivision('Popular')}><Glyphicon glyph="fire" /> Who Should McGregor Fight Next? </a>
                </Navbar.Brand>
                <Navbar.Toggle style={{margin: 20}}/>
              </Navbar.Header>
              <Navbar.Collapse>
                <Nav>
                  <NavDropdown eventKey={3} title="Divisions" id="basic-nav-dropdown">
                    <MenuItem eventKey={3.3} onClick={()=>self.changeDivision('Featherweight')}>Featherweight</MenuItem>
                    <MenuItem eventKey={3.4} onClick={()=>self.changeDivision('Lightweight')}>Lightweight</MenuItem>
                    <MenuItem eventKey={3.5} onClick={()=>self.changeDivision('Welterweight')}>Welterweight</MenuItem>
                  </NavDropdown>
                </Nav>                
                <Nav>
                  <MenuItem eventKey={2} href="https://www.mmamatchups.net"><Glyphicon glyph="fire" />   View All Fighters</MenuItem>
                </Nav>
                <Nav pullRight>
                  <MenuItem eventKey={1} href="/auth/google_oauth2"><Glyphicon glyph="log-in" />   Sign In With Google</MenuItem>
                </Nav>
              </Navbar.Collapse>
            </Navbar>
          </div>
        );
      }else{

        // User is using Desktop and is logged in
        return (
          <div>
            <Navbar inverse collapseOnSelect fixedTop>
              <Navbar.Header>
                <Navbar.Brand>
                  {/*<a href="#"><img src="https://i.imgur.com/Xs3GP6z.png" style={{width: '65px', marginBottom: '5px'}} /></a>*/}
                  <a style={{color: 'white'}} href="#" onClick={()=>self.changeDivision('Popular')}><Glyphicon glyph="fire" /> Who Should McGregor Fight Next? </a>
                </Navbar.Brand>
                <Navbar.Toggle style={{margin: 20}}/>
              </Navbar.Header>
              <Navbar.Collapse>
                <Nav>
                  <NavDropdown eventKey={3} title="Divisions" id="basic-nav-dropdown">
                    <MenuItem eventKey={3.3} onClick={()=>self.changeDivision('Featherweight')}>Featherweight</MenuItem>
                    <MenuItem eventKey={3.4} onClick={()=>self.changeDivision('Lightweight')}>Lightweight</MenuItem>
                    <MenuItem eventKey={3.5} onClick={()=>self.changeDivision('Welterweight')}>Welterweight</MenuItem>
                  </NavDropdown>
                </Nav>
                <Nav>
                  <MenuItem eventKey={2} href="https://www.mmamatchups.net"><Glyphicon glyph="fire" />   View All Fighters</MenuItem>
                </Nav>
                <Nav pullRight>
                  <MenuItem eventKey={2} href="signout"><Glyphicon glyph="log-out" />   Log Out</MenuItem>
                </Nav>
              </Navbar.Collapse>
            </Navbar>
          </div>
        );
      }
    }
    
  }
}
