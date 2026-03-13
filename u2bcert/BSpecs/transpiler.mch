/* transpiler
 * Author: 
 * Creation date: 29/01/2026
 */
MACHINE
    transpiler
INCLUDES
    u2bcertutils
DEFINITIONS
  SET_PREF_ALLOW_COMPLEX_LETS == TRUE;
  SET_PREF_MAX_OPERATIONS == 1;
  initRel == { cc,ss | cc : SComposite & (∃ts.(ts : TStart & ts : transitions~[{cc}] & ss = starget(ts))) };
    
    /* --- Common preconditions for creating a fresh event+branch for a transition --- */
    FRESH_EVT_OK(tt,be) == (be : BEVENT & be /: BEvent
         & sTDiagrams_TEvent_name(tt) /: ran(bMachine_BEvent_name));
    
    ALLOC_BRANCH_OK(br,bs,act_to) == (br : BRANCH  & br /: Branch
         & bs : BSTATE & bs /: BState & bs /: dom(simple) & bs /: dom(composite)
         & act_to : BACTION & act_to /: BAction);
    
    /* Source is a simple UML state, and srcSid is its translated StateId */
    SIMPLE_SRC_OK(tt,srcSid) == ( tsource(tt) : SSimple
        & sTDiagrams_State_name(tsource(tt)) : ran(bMachine_StateId_name)  /* WD helper */
        & srcSid = bMachine_StateId_name~(sTDiagrams_State_name(tsource(tt)))
    );
    
    /* Target is simple UML state, and tgtSid is its translated StateId */
    SIMPLE_TGT_OK(tt,tgtSid) == ( ttarget(tt) : SSimple
        & sTDiagrams_State_name(ttarget(tt)) : ran(bMachine_StateId_name)  /* WD helper */
        & tgtSid = bMachine_StateId_name~(sTDiagrams_State_name(ttarget(tt)))
        );
    
    /* Target is composite UML state; sm is a reachable simple state under initRel; tgtSid is its translation */
    COMPOSITE_TGT_OK(tt,sm,tgtSid) ==  ( ttarget(tt) : SComposite
        & sm : (closure1(initRel))[{ttarget(tt)}] - dom(initRel)
        & sm : SSimple
        & sTDiagrams_State_name(sm) : ran(bMachine_StateId_name)           /* WD helper */
        & tgtSid = bMachine_StateId_name~(sTDiagrams_State_name(sm))
    );
    
    /* Source is a composite UML state, and srcSd is its translated StateDef */
    COMPOSITE_SRC_OK(tt,srcSd) == ( tsource(tt) : SComposite
        & sTDiagrams_State_name(tsource(tt)) : ran(bMachine_StateDef_name)     /* WD helper */
        & srcSd = bMachine_StateDef_name~(sTDiagrams_State_name(tsource(tt)))
    );
    TGT_OK(tt,tgtSid) == (
        ( SIMPLE_TGT_OK(tt,tgtSid)
          or (#sm.( COMPOSITE_TGT_OK(tt,sm,tgtSid) )) )
        &
        /* WD helper: if target is composite, all candidate leaf simple states have a known translation */
        ( ttarget(tt) : SComposite =>
            sTDiagrams_State_name[
                (closure1(initRel))[{ttarget(tt)}] - dom(initRel)
            ] <: ran(bMachine_StateId_name)
        )
    );
    EXISTING_EVT_OK(tt,be) == ( be : BEvent
        & bMachine_BEvent_name(be) = sTDiagrams_TEvent_name(tt)
    )
     
CONSTANTS
	st, bm
PROPERTIES
	st : STModel & bm : BMachine	
	
	/* well definedness because the usage of card */
	& BEVENT: FIN(BEVENT) 
	& TRANSITION: FIN(TRANSITION) 
	& STATE: FIN(STATE) 
	& STATEDEF: FIN(STATEDEF) 
	& STATEID: FIN(STATEID) 
	& SSimple : FIN(State)
	& GUARDDEF: FIN(GUARDDEF) 
	& TGUARD: FIN(TGUARD) 
	& BRANCH: FIN(BRANCH) 
	& BACTION: FIN(BACTION) 
	& BSTATE: FIN(BSTATE)
	& State: FIN(State)
	& ran(sTDiagrams_State_name) : FIN(STR)
	
	& card(BEVENT) = card(TRANSITION)
	& card(STATEID) = card(STATE)
	& card(STATEDEF) = card(STATE) 
	& card(GUARDDEF) = card(TGUARD)
	& card(BRANCH) = card(TRANSITION)
	& card(BACTION) = 2 * card(TRANSITION)
	& card(BSTATE) = 2 * card(TRANSITION)
	
	& dom(states) = State - ran(root) 
	& (TStart <| transitions) : TStart >-> SComposite 
	& card(ran(sTDiagrams_State_name)) = card(State) 
	
	& SSimple /\ SComposite = {}
	& TStart /\ TEvent = {}

VARIABLES
	doneEvt, doneAct, tr2br

INVARIANT
	
	doneEvt <: TEvent
	& doneAct <: TEvent
	
	/* No two transitions share the same branch */
    & tr2br : doneEvt >->> Branch
	
	& (binvs /= {} => ran(binvs) = invs[{st}])
	
	& (elems = StateId * {bm}) 
	
	& (grdDefs = GuardDef * {bm})
	
	& (stDefs = StateDef * {bm})
	
	& (events = BEvent * {bm})
	
	& (elems /= {} => 
	        card(StateId) = card(SSimple)
	        & bMachine_StateId_name[StateId] = ran(SSimple <| sTDiagrams_State_name)
	)
	
	/* la relation inverse est aussi injective */
    & bMachine_StateId_name~ : ran(bMachine_StateId_name) +-> StateId
    
    & bMachine_StateDef_name : StateDef >+> STR
	
	/* Once the initial state is set, it points to an existing StateId. */
    & (initS /= {} => ran(initS) <: StateId)
	
	& (grdDefs /= {} => card(GuardDef) = card(guard~[{st}])
        & bMachine_GuardDef_name[GuardDef] = ran(guard~[{st}] <| sTDiagrams_TGuard_name)
        & bval[GuardDef] = ran(guard~[{st}] <| val))
    	
	& ran(bMachine_StateDef_name) <: ran(SComposite <| sTDiagrams_State_name)
	
	& ran(refs) <: bMachine_StateId_name~[ ran(SSimple <| sTDiagrams_State_name) ]
	
	& bMachine_StateDef_name[dom(unionWith) \/ ran(unionWith)] <: ran(SComposite <| sTDiagrams_State_name)
	
	/* Grammar alternative: a BAction is either state update OR operation call */
    & dom(to) /\ dom(op) = {}
    & dom(to) \/ dom(op) = BAction
    
    /* Grammar alternative: a BState is either simple or composite */
    & dom(simple) /\ dom(composite) = {}
    & dom(simple) \/ dom(composite) = BState
    
    /* A guard is only attached to a branch that comes from a UML transition carrying a guard */
    & dom(cond) <: tr2br[dom(tguard)]
    /* cond is only defined for already created branches */
    & dom(cond) <: ran(tr2br)
    
    
    
    /* Every operation-call action op(act) is attached to some branch via subs. */
    & dom(op) <: dom(subs)
    
    /* Every branch created by the transpilation is well-formed:
     * it is linked to an event, has a source state, and has at least one action.
     */
    & ran(tr2br) <: dom(branches) /\ ran(subs) /\ dom(from)
	
ASSERTIONS
    /* Structural invariants: ownership of generated target elements */
    dom(elems) = StateId & (elems /= {} => ran(elems) = {bm}) &
    dom(grdDefs) = GuardDef & (grdDefs /= {} => ran(grdDefs) = {bm}) &
    dom(stDefs) = StateDef & (stDefs /= {} => ran(stDefs) = {bm}) &
    dom(events) = BEvent & (events /= {} => ran(events) = {bm}) &
    
    
    /* domain inclusions (helpful for proofs, implied by typing) */
    dom(simple) <: BState &
    dom(composite) <: BState 	&
    dom(bMachine_StateId_name~) = ran(bMachine_StateId_name)
	
INITIALISATION
	doneEvt, doneAct, tr2br := {}, {}, {}

OPERATIONS
	
inclusion = 
	SELECT inc = {} THEN
		setInc(bm, sTDiagrams_State_name(root(st)))	
	END ;
		
invariants =
  SELECT 
  	binvs = {} & invs /= {} & initS /= {}
  THEN
    setInvs(bm, invs[{st}])
  END;

initState =
  SELECT
      elems /= {} &
      initS = {}
  THEN
      ANY sm, sid WHERE
          sm : SSimple &
          sm : (closure1(initRel))[{root(st)}] - dom(initRel) &
          sid : StateId &
          bMachine_StateId_name(sid) = sTDiagrams_State_name(sm) 
      THEN
          setInit(bm, sid)
      END
  END;

simpleStates =
  SELECT
      elems = {} & refs = {} & simple = {} & to = {} & initS = {}
  THEN
      ANY stIds, nameMap WHERE
          stIds : FIN(STATEID)
        & card(stIds) = card(SSimple)
        & nameMap : stIds >->> ran(SSimple <| sTDiagrams_State_name)
      THEN
          setSimpleStates(bm, stIds, nameMap)
      END
  END;
  
compositeState =
  SELECT elems /= {} THEN
    ANY cs, sd WHERE
          cs : SComposite
      &   cs /= root(st)
      &   sTDiagrams_State_name(cs) /: ran(bMachine_StateDef_name)
      &   sd : STATEDEF - StateDef
    THEN
      LET snames, sids BE
            snames = ran( (SSimple /\ states~[{cs}]) <| sTDiagrams_State_name )
          & sids   = bMachine_StateId_name~[snames]
      IN
          addCompositeState(bm, sd, sTDiagrams_State_name(cs), sids)
      END
    END
  END;

linkUnionWith =
  ANY cs, sd, childs WHERE
      cs : SComposite & cs /= root(st)
    & sTDiagrams_State_name(cs) : ran(bMachine_StateDef_name)

    /* sd est le StateDef correspondant à cs */
    & sd : StateDef
    & {sd} = bMachine_StateDef_name~[{sTDiagrams_State_name(cs)}]
    & sd /: dom(unionWith)

    /* enfants composites déjà traduits (par leur nom) */
    & childs <: StateDef
    & childs =
        bMachine_StateDef_name~
          [ ran( (SComposite /\ states~[{cs}]) <| sTDiagrams_State_name ) ]

    & childs /= {}
  THEN
    addUnionWith(bm, sd, childs)
  END;

guardDefs =
  SELECT
      grdDefs = {} & GuardDef = {} & cond = {} & guard /= {}
  THEN
    ANY gdIds, gmap WHERE
        gdIds : FIN(GUARDDEF)
      & guard~[{st}] : FIN(TGUARD)
      & gmap : gdIds >->> guard~[{st}]
      & card(gdIds) = card(guard~[{st}])
    THEN
      setGuardDefs(
        bm,
        gdIds,
        (gmap ; sTDiagrams_TGuard_name),
        (gmap ; val)
      )
    END
  END;

addEventBranchFresh =
  ANY tt, be, br, bs, act_to WHERE
        tt : TEvent &   tt /: doneEvt
        &   FRESH_EVT_OK(tt,be)
        &   ALLOC_BRANCH_OK(br,bs,act_to)
  THEN
    ANY tgtSid WHERE
          tgtSid : StateId & TGT_OK(tt,tgtSid)
    THEN
      doneEvt := doneEvt \/ {tt} ||
      tr2br(tt) := br ||

      SELECT tsource(tt) : SSimple THEN
        ANY srcSid WHERE
              srcSid : StateId & SIMPLE_SRC_OK(tt,srcSid)
        THEN
          addFreshEventWithBranch_SimpleSrc(
              bm, be, sTDiagrams_TEvent_name(tt),
              br, bs, act_to, srcSid, tgtSid)
        END

      WHEN tsource(tt) : SComposite THEN
        ANY srcSd WHERE
              srcSd : StateDef & COMPOSITE_SRC_OK(tt,srcSd)
        THEN
          addFreshEventWithBranch_CompositeSrc(
              bm, be, sTDiagrams_TEvent_name(tt),
              br, bs, act_to, srcSd, tgtSid)
        END
      END
    END
  END;
  
addEventBranchExisting =
  ANY tt, be, br, bs, act_to WHERE
        tt : TEvent & tt /: doneEvt
        &   EXISTING_EVT_OK(tt,be)
        &   ALLOC_BRANCH_OK(br,bs,act_to)
  THEN
    ANY tgtSid WHERE
          tgtSid : StateId &   TGT_OK(tt,tgtSid)
    THEN
      doneEvt := doneEvt \/ {tt} ||
      tr2br(tt) := br ||

      SELECT tsource(tt) : SSimple THEN
        ANY srcSid WHERE
              srcSid : StateId & SIMPLE_SRC_OK(tt,srcSid)
        THEN
          addBranchToExistingEvent_SimpleSrc(
              bm, be, br, bs, act_to, srcSid, tgtSid)
        END

      WHEN tsource(tt) : SComposite THEN
        ANY srcSd WHERE
              srcSd : StateDef & COMPOSITE_SRC_OK(tt,srcSd)
        THEN
          addBranchToExistingEvent_CompositeSrc(
              bm, be, br, bs, act_to, srcSd, tgtSid)
        END
      END
    END
  END;

addBranchGuard =
  SELECT
        grdDefs /= {} & GuardDef /= {}
  THEN
    ANY tt, br, gd WHERE
          tt : TEvent & tt : doneEvt & tt : dom(tguard)
          &   br : Branch & br /: dom(cond)
          &   tr2br(tt) = br 
          &   gd : GuardDef
          &   bMachine_GuardDef_name(gd) = sTDiagrams_TGuard_name(tguard(tt))
    THEN
          setBranchGuard(br, gd)
    END
  END;

addBranchAction =
  SELECT
        dom(tr2br) = doneEvt & doneAct <: doneEvt
  THEN
    ANY tt, br, act WHERE
          tt : TEvent &   tt : doneEvt &   tt : dom(taction) &   tt /: doneAct
          &   br = tr2br(tt)
          &   act : (BACTION - BAction)
    THEN
      doneAct := doneAct \/ {tt} ||
      addOpActionToBranch(br, act, taction(tt))
    END
  END
  	
END
