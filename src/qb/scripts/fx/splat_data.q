Splat_Critical_Remaining_Polys_Pcnt = 0.5
Splat_Alpha_Degen_Rate = 8

script PreAllocSplats
	Printf \{ "Initializing SplatHeap" }
	PreAllocTextureSplat \{ name = 'JOW_Grit01' Material = sys_BloodSplat01_sys_BloodSplat01 }
	PreAllocTextureSplat \{ name = 'JOW_Puff01' Material = sys_BloodSplat02_sys_BloodSplat02 }
	PreAllocTextureSplat \{ name = 'skidtrail' Material = sys_skidmark_sys_skidmark }
endscript
