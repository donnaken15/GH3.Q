GP_StarPower_Bats01 = {
	Pos = (0.3568880259990692, -11.769608497619629, 0.07137700170278549)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	Type = flat
	Active
	CreatedAtStart
	Attach
	Bone = BONE_PELVIS
	EmitRangeDims = (0.699999988079071, 0.699999988079071, 0.699999988079071)
	Emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 1.0
	PerParticleWind
	EmitterVelocityWeight = 0.0
	Radiate
	ElevSpread = (90.0, 90.0)
	SweepSpread = (0.0, 360.0)
	LifeRange = (2.0, 2.5)
	Emit_Rate = 6.0
	Max = 0
	TimeSeed = 0.5
	LifeTime = 0.0
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [ (0.699999988079071, 1.0) (0.10000000149011612, 0.10000000149011612) ]
	SpeedRange = (1.0, 2.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = World
	Color = -1
	NoVisibilityTest
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Bats01
		SpecularPower = 0
		AlphaCutoff = 128
		BlendMode = diffuse
		SoftEdge
		SoftedgeScale = 1.0
		QuadAnimationFPS = 18
	}
	Knot = [
		(-5.710206985473633, 0.0, -0.28551000356674194)
		(-5.710206985473633, 0.0, -0.28551000356674194)
		(-2.784687042236328, 0.0, -0.14275500178337097)
		(0.1408339887857437, 0.0, 0.0)
		(3.066354990005493, 0.0, 0.14275500178337097)
		(3.9952242374420166, 0.0, 0.14275500178337097)
		(4.924093246459961, 0.0, 0.14275500178337097)
		(5.852962017059326, 0.0, 0.14275500178337097)
		(5.852962017059326, 0.0, 0.14275500178337097)
	]
	ParticleColor = [
		-1
		-1
		-1
		-1
		-256
		-256
	]
	VertexWeight = [ 0.759227 1.0 ]
}
