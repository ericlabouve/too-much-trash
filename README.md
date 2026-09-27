# Too Much Trash

**Every piece of litter is a chance to teach a robot how to help.**

Too Much Trash is an experiment in collecting the kind of real-world experience autonomous cleanup robots need: what debris looks like from a gripper’s point of view, how a hand approaches it, and what happens when a grasp succeeds or fails. The goal is a practical, growing dataset of everyday pickup attempts in messy environments, followed by perception and imitation-learning research that can turn those examples into useful robotic behavior.

The collection tool starts with an ordinary reacher grabber. A lightweight, 3D-printed mount places an iPhone near its claw so the camera sees the approach and grasp. A mechanical pull cable connects the stock handle trigger to a small actuator at the phone’s volume button. Each squeeze marks a grasp event while a rolling video buffer preserves the moments before contact. The mechanism is designed to leave the grabber’s internals alone and avoid additional electronics.

The person collecting litter holds a separate bucket in their other hand. A successful deposit into that bucket provides a useful signal that the object was picked up and accepted as trash; misses, drops, and rejected objects are valuable examples too. Those signals are starting points for labeling, not a claim that every outcome can be inferred perfectly without review.

This repository brings the whole effort together: a hosted service for collecting and processing media, desktop and browser experiences for reviewing it, a dedicated iOS experience for capture and review, a workspace for segmentation and classification experiments, and a CAD studio for the grabber retrofit. The first concept renders live in [`cad/renders`](cad/renders/README.md). They illustrate the intended mechanical relationships and will guide prototypes, measurements, and fit testing.

The proposed retrofit is shown from the front and from a rotated side view. Blue marks the original grabber handle and center brace; orange marks added 3D-printed parts. These are concept drawings, not dimensioned manufacturing plans.

| Front concept (1a) | Rotated side concept (1b) |
| --- | --- |
| ![Front view of the reacher grabber with an iPhone mount and cable-driven trigger](cad/renders/01a-complete-front.png) | ![Rotated side view of the reacher grabber retrofit with the stock blue center brace visible below the phone](cad/renders/01b-complete-side.png) |

The aspiration is simple: make it easier to gather honest examples of litter pickup at scale, learn from the awkward attempts as well as the clean ones, and help future robots do more of the work of keeping shared spaces clean.
