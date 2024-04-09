singer_female_animations = {
	Stance_A = {
		Idle = {
			Good = {
				FAST = [
					GH3_Singer_Fem_NoSing_Fst_Idle01
					GH3_Singer_Fem_NoSing_Fst_Idle02
					GH3_Singer_Fem_NoSing_Fst_Idle03
					GH3_Singer_Fem_NoSing_Fst_Idle04
					GH3_Singer_Fem_NoSing_Fst_Clap
					GH3_Singer_Fem_NoSing_Fst_FistPmp
				]
				Med = [
					GH3_Singer_Fem_NoSing_Med_Idle01
					GH3_Singer_Fem_NoSing_Med_Idle02
					GH3_Singer_Fem_NoSing_Med_Idle03
					GH3_Singer_Fem_NoSing_Med_Idle04
					GH3_Singer_Fem_NoSing_Med_Idle05
					GH3_Singer_Fem_NoSing_Med_Idle06
					GH3_Singer_Fem_NoSing_Med_IdleClap
				]
				Slow = [
					GH3_Singer_Fem_Slw_NSIdle1
					GH3_Singer_Fem_Slw_NSIdle2
					GH3_Singer_Fem_Slw_NSIdle3
					GH3_Singer_Fem_Slw_NSSolo2
					GH3_Singer_Fem_Slw_NSSolo3
					GH3_Singer_Fem_Slw_NSSolo5
				]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_NoSing_Fst_Idle01 GH3_Singer_Fem_NoSing_Fst_Idle02 GH3_Singer_Fem_NoSing_Fst_Idle03 GH3_Singer_Fem_NoSing_Fst_Idle04 ]
				Med = [ GH3_Singer_Fem_NoSing_Med_Idle01 GH3_Singer_Fem_NoSing_Med_Idle02 GH3_Singer_Fem_NoSing_Med_Idle03 GH3_Singer_Fem_NoSing_Med_Idle04 ]
				Slow = [
					GH3_Singer_Fem_Slw_NSIdle1
					GH3_Singer_Fem_Slw_NSIdle2
					GH3_Singer_Fem_Slw_NSIdle3
					GH3_Singer_Fem_Slw_NSSolo2
					GH3_Singer_Fem_Slw_NSSolo3
					GH3_Singer_Fem_Slw_NSSolo5
				]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_NoSing_Fst_Idle01 GH3_Singer_Fem_NoSing_Fst_hips ]
				Med = [ GH3_Singer_Fem_NoSing_Med_Idle01 GH3_Singer_Fem_NoSing_Med_Idle02 ]
				Slow = [ GH3_Singer_Fem_Slw_NSIdle1 GH3_Singer_Fem_Slw_NSIdle3 GH3_Singer_Fem_Slw_NSSolo2 ]
			}
		}
		Special = {
			Good = {
				FAST = [
					GH3_Singer_Fem_Sing_Fst_Spec01
					GH3_Singer_Fem_Sing_Fst_Spec02
					GH3_Singer_Fem_Sing_Fst_Spec03
					GH3_Singer_Fem_Sing_Fst_Spec04
					GH3_Singer_Fem_Sing_Fst_Spec05
				]
				Med = [
					GH3_Singer_Fem_NoSing_Med_HdBang
					GH3_Singer_Fem_NoSing_Med_Spin
					GH3_Singer_Fem_NoSing_Med_Pump
					GH3_Singer_Fem_NoSing_Med_Shfl
					GH3_Singer_Fem_NoSing_Med_Back
				]
				Slow = [
					GH3_Singer_Fem_Slw_NSSolo1
					GH3_Singer_Fem_Slw_NSSolo2
					GH3_Singer_Fem_Slw_NSSolo3
					GH3_Singer_Fem_Slw_NSSolo4
					GH3_Singer_Fem_Slw_NSSolo5
					GH3_Singer_Fem_Slw_NSSolo6
					GH3_Singer_Fem_Slw_NSSolo7
				]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Spec01 GH3_Singer_Fem_Sing_Fst_Spec03 GH3_Singer_Fem_Sing_Fst_Spec05 ]
				Med = [ GH3_Singer_Fem_NoSing_Med_Pump GH3_Singer_Fem_NoSing_Med_Shfl GH3_Singer_Fem_NoSing_Med_Back ]
				Slow = [
					GH3_Singer_Fem_Slw_NSSolo1
					GH3_Singer_Fem_Slw_NSSolo2
					GH3_Singer_Fem_Slw_NSSolo3
					GH3_Singer_Fem_Slw_NSSolo4
					GH3_Singer_Fem_Slw_NSSolo5
					GH3_Singer_Fem_Slw_NSSolo6
					GH3_Singer_Fem_Slw_NSSolo7
				]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_NoSing_Fst_FistPmp ]
				Med = [ GH3_Singer_Fem_NoSing_Med_Idle01 GH3_Singer_Fem_NoSing_Med_Idle02 ]
				Slow = [ GH3_Singer_Fem_Slw_NSSolo1 GH3_Singer_Fem_Slw_NSSolo2 GH3_Singer_Fem_Slw_NSSolo4 GH3_Singer_Fem_Slw_NSSolo6 ]
			}
		}
		Transitions = {
			Stance_B = {
				Good = { FAST = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng Slow = GH3_Singer_Fem_Trans_NoSngSng }
				Normal = { FAST = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng Slow = GH3_Singer_Fem_Trans_NoSngSng }
				Bad = { FAST = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng Slow = GH3_Singer_Fem_Trans_NoSngSng }
			}
			Intro = gh3_singer_fem_intro2
		}
	}
	Stance_B = {
		Idle = {
			Good = {
				FAST = [
					GH3_Singer_Fem_Sing_Fst_Idle01
					GH3_Singer_Fem_Sing_Fst_Idle02
					GH3_Singer_Fem_Sing_Fst_Idle03
					GH3_Singer_Fem_Sing_Fst_Idle04
					GH3_Singer_Fem_Sing_Fst_Idle05
					GH3_Singer_Fem_Sing_Fst_Idle06
					GH3_Singer_Fem_Sing_Fst_IdleWave
					GH3_Singer_Fem_Sing_Fst_IdleBig
					GH3_Singer_Fem_Sing_Fst_Solo03
					GH3_Singer_Fem_Sing_Fst_Solo04
					GH3_Singer_Fem_Sing_Fst_Solo05
				]
				Med = [
					GH3_Singer_Fem_Sing_Med_Idle01
					GH3_Singer_Fem_Sing_Med_Idle02
					GH3_Singer_Fem_Sing_Med_Idle03
					GH3_Singer_Fem_Sing_Med_Idle04
					GH3_Singer_Fem_Sing_Med_Idle05
					GH3_Singer_Fem_Sing_Med_Idle06
					GH3_Singer_Fem_Sing_Med_Spec_LngL
					GH3_Singer_Fem_Sing_Med_Spec_LngR
				]
				Slow = [
					GH3_Singer_Fem_Slw_SIdle1
					GH3_Singer_Fem_Slw_SIdle2
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo3
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
					GH3_Singer_Fem_Slw_SSpecial4
				]
			}
			Normal = {
				FAST = [
					GH3_Singer_Fem_Sing_Fst_Idle01
					GH3_Singer_Fem_Sing_Fst_Idle02
					GH3_Singer_Fem_Sing_Fst_Idle03
					GH3_Singer_Fem_Sing_Fst_Idle04
					GH3_Singer_Fem_Sing_Fst_Idle05
					GH3_Singer_Fem_Sing_Fst_IdleWave
					GH3_Singer_Fem_Sing_Fst_IdleBig
					GH3_Singer_Fem_Sing_Fst_Solo01
					GH3_Singer_Fem_Sing_Fst_Solo04
				]
				Med = [
					GH3_Singer_Fem_Sing_Med_Idle01
					GH3_Singer_Fem_Sing_Med_Idle02
					GH3_Singer_Fem_Sing_Med_Idle03
					GH3_Singer_Fem_Sing_Med_Idle04
					GH3_Singer_Fem_Sing_Med_Idle05
					GH3_Singer_Fem_Sing_Med_Idle06
					GH3_Singer_Fem_Sing_Med_Spec_LngL
					GH3_Singer_Fem_Sing_Med_Spec_LngR
				]
				Slow = [
					GH3_Singer_Fem_Slw_SIdle1
					GH3_Singer_Fem_Slw_SIdle2
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo3
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
				]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Idle01 GH3_Singer_Fem_Sing_Fst_Solo02 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 GH3_Singer_Fem_Sing_Med_Idle03 ]
				Slow = [
					GH3_Singer_Fem_Slw_SIdle1
					GH3_Singer_Fem_Slw_SIdle2
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
				]
			}
		}
		Special = {
			Good = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Idle01 GH3_Singer_Fem_Sing_Fst_Spec02 GH3_Singer_Fem_Sing_Fst_Spec05 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Spec_jmp GH3_Singer_Fem_Sing_Med_Spec_Spn1 GH3_Singer_Fem_Sing_Med_Spec_Spn2 GH3_Singer_Fem_Sing_Med_Spec_Spn3 ]
				Slow = [
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo3
					GH3_Singer_Fem_Slw_SSolo4
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
					GH3_Singer_Fem_Slw_SSolo7
					GH3_Singer_Fem_Slw_SSpecial1
					GH3_Singer_Fem_Slw_SSpecial2
					GH3_Singer_Fem_Slw_SSpecial3
					GH3_Singer_Fem_Slw_SSpecial4
					GH3_Singer_Fem_Slw_SSpecial5
					GH3_Singer_Fem_Slw_SSpecial6
				]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Spec01 GH3_Singer_Fem_Sing_Fst_Spec05 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Spec_jmp GH3_Singer_Fem_Sing_Med_Spec_Spn1 GH3_Singer_Fem_Sing_Med_Spec_Spn2 GH3_Singer_Fem_Sing_Med_Spec_Spn3 ]
				Slow = [
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo3
					GH3_Singer_Fem_Slw_SSolo4
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
					GH3_Singer_Fem_Slw_SSolo7
					GH3_Singer_Fem_Slw_SSpecial1
					GH3_Singer_Fem_Slw_SSpecial2
					GH3_Singer_Fem_Slw_SSpecial3
					GH3_Singer_Fem_Slw_SSpecial5
					GH3_Singer_Fem_Slw_SSpecial6
				]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 GH3_Singer_Fem_Sing_Med_Idle02 ]
				Slow = [
					GH3_Singer_Fem_Slw_SSolo1
					GH3_Singer_Fem_Slw_SSolo2
					GH3_Singer_Fem_Slw_SSolo3
					GH3_Singer_Fem_Slw_SSolo4
					GH3_Singer_Fem_Slw_SSolo5
					GH3_Singer_Fem_Slw_SSolo6
					GH3_Singer_Fem_Slw_SSolo7
					GH3_Singer_Fem_Slw_SSpecial1
					GH3_Singer_Fem_Slw_SSpecial3
					GH3_Singer_Fem_Slw_SSpecial6
				]
			}
		}
		Jump = {
			Good = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
		}
		Kick = {
			Good = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
		}
		RELEASE = {
			Good = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Spec04 GH3_Singer_Fem_Sing_Fst_Spec03 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Spec04 GH3_Singer_Fem_Sing_Fst_Spec03 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_Sing_Fst_Idle01 ]
				Med = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
				Slow = [ GH3_Singer_Fem_Sing_Med_Idle01 ]
			}
		}
		Long_Note = {
			Good = {
				FAST = [ GH3_Singer_Fem_LongNote_1 ]
				Med = [ GH3_Singer_Fem_LongNote_1 ]
				Slow = [ GH3_Singer_Fem_LongNote_1 ]
			}
			Normal = {
				FAST = [ GH3_Singer_Fem_LongNote_1 ]
				Med = [ GH3_Singer_Fem_LongNote_1 ]
				Slow = [ GH3_Singer_Fem_LongNote_1 ]
			}
			Bad = {
				FAST = [ GH3_Singer_Fem_LongNote_1 ]
				Med = [ GH3_Singer_Fem_LongNote_1 ]
				Slow = [ GH3_Singer_Fem_LongNote_1 ]
			}
		}
		Transitions = {
			Stance_A = {
				Good = { FAST = GH3_Singer_Fem_Trans_SngNoSng_hop Med = GH3_Singer_Fem_Trans_SngNoSng_hop Slow = GH3_Singer_Fem_Trans_SngNoSng_hop }
				Normal = { FAST = GH3_Singer_Fem_Trans_SngNoSng Med = GH3_Singer_Fem_Trans_Med_SngNoSng Slow = GH3_Singer_Fem_Trans_SngNoSng }
				Bad = { FAST = GH3_Singer_Fem_Trans_SngNoSng Med = GH3_Singer_Fem_Trans_Med_SngNoSng Slow = GH3_Singer_Fem_Trans_SngNoSng }
			}
			Intro = GH3_Singer_Fem_Trans_SngNoSng
			Win = GH3_Singer_Fem_Trans_SngNoSng_hop
			Lose = GH3_Singer_Fem_Trans_SngNoSng
		}
	}
	Intro = {
		Idle = {
			Good = {
				FAST = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Med = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Slow = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
			}
			Normal = {
				FAST = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Med = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Slow = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
			}
			Bad = {
				FAST = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Med = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
				Slow = [ gh3_singer_fem_intro4 gh3_singer_fem_intro5 gh3_singer_fem_intro6 ]
			}
		}
		Transitions = {
			Stance_B = {
				Good = { Slow = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng FAST = GH3_Singer_Fem_Trans_NoSngSng }
				Normal = { Slow = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng FAST = GH3_Singer_Fem_Trans_NoSngSng }
				Bad = { Slow = GH3_Singer_Fem_Trans_NoSngSng Med = GH3_Singer_Fem_Trans_Med_NoSngSng FAST = GH3_Singer_Fem_Trans_NoSngSng }
			}
		}
	}
	Win = {
		Idle = {
			Good = {
				FAST = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Med = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Slow = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
			}
			Normal = {
				FAST = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Med = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Slow = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
			}
			Bad = {
				FAST = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Med = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
				Slow = [ gh3_singer_fem_win1 gh3_singer_fem_win2 gh3_singer_fem_win3 ]
			}
		}
		Transitions = { Stance_B = GH3_Singer_Fem_Trans_Med_NoSngSng }
	}
	Lose = {
		Idle = {
			Good = {
				FAST = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Med = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Slow = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
			}
			Normal = {
				FAST = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Med = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Slow = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
			}
			Bad = {
				FAST = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Med = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
				Slow = [ gh3_singer_fem_lose1 gh3_singer_fem_lose2 gh3_singer_fem_lose3 ]
			}
		}
		Transitions = { Stance_B = GH3_Singer_Fem_Trans_Med_NoSngSng }
	}
	facial_anims = {
		Idle = [ #"0x74898c0a" #"0x74898c0a" #"0x1365325e" ]
	}
}
